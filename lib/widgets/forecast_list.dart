import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastData = Provider.of<WeatherProvider>(context).forecastData;

    if (forecastData == null || forecastData.isEmpty) {
      return const Center(
        child: Text(
          'No forecast data available.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

   
    List<Widget> forecastItems = List.generate(5, (index) {
      final item = forecastData[index];
      final dateTime = DateTime.parse(item['dt_txt']);
      final day = DateFormat('E').format(dateTime);
      final temp = "${item['main']['temp'].toInt()}°C";
      final iconCode = item['weather'][0]['icon'];
      final iconData = _mapWeatherIcon(iconCode);

      return Expanded(
        child: ForecastItem(day: day, temp: temp, icon: iconData),
      );
    });

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.5),
            child: Text(
              'Upcoming Days Weather',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: forecastItems,
            ),
          ),
        ],
      ),
    );
  }

  IconData _mapWeatherIcon(String code) {
    switch (code) {
      case '01d':
      case '01n':
        return Icons.wb_sunny;
      case '02d':
      case '02n':
        return Icons.wb_cloudy;
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return Icons.cloud;
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return Icons.grain;
      case '11d':
      case '11n':
        return Icons.flash_on;
      case '13d':
      case '13n':
        return Icons.ac_unit;
      case '50d':
      case '50n':
        return Icons.blur_on;
      default:
        return Icons.help_outline;
    }
  }
}

class ForecastItem extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temp;

  const ForecastItem({
    super.key,
    required this.day,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
