import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherService {
  final String apiKey = 'baf23d71eb4f1581722c5a6974acce23';

  Future<Map<String, dynamic>?> fetchCurrentWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<List<dynamic>?> fetchFiveDayForecast(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final now = DateTime.now();
      final tomorrow = DateTime(now.year, now.month, now.day + 1);

    
      final futureForecasts = (decoded['list'] as List).where((item) {
        return DateTime.parse(item['dt_txt']).isAfter(tomorrow.subtract(const Duration(seconds: 1)));
      }).toList();

   
      final dailyForecasts = <String, dynamic>{};
      for (final item in futureForecasts) {
        final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(item['dt_txt']));
        if (!dailyForecasts.containsKey(date)) {
          dailyForecasts[date] = item;
          if (dailyForecasts.length == 5) break;
        }
      }

      return dailyForecasts.values.toList();
    }
    return null;
  }
}