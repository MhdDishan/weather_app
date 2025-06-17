import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;

    if (weatherData == null) {
      return const SizedBox(); 
    }

    final temperature = weatherData['main']['temp'].round().toString();
    final condition = weatherData['weather'][0]['main'];

    return Column(
      children: [
        Text(
          '$temperature°C',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          condition,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
