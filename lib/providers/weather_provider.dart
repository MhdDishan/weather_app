import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  Map<String, dynamic>? _weatherData;
  List<dynamic>? _forecastData;
  String _city = 'Nilambur';
  bool _isLoading = false;

  Map<String, dynamic>? get weatherData => _weatherData;
  List<dynamic>? get forecastData => _forecastData;
  String get city => _city;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    notifyListeners();

    final current = await _weatherService.fetchCurrentWeather(cityName);
    final forecast = await _weatherService.fetchFiveDayForecast(cityName);

    if (current != null && forecast != null) {
      _weatherData = current;
      _forecastData = forecast;
      _city = cityName;
    }

    _isLoading = false;
    notifyListeners();
  }
}
