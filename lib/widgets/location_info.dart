import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'package:intl/intl.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;

    if (weatherData == null) {
      return const Text(
        'Enter a city to get weather',
        style: TextStyle(color: Colors.white70),
      );
    }

    final city = weatherData['name'];
    final dateTime = DateTime.now();
    final formattedDate = DateFormat('EEEE, d MMMM').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 24),
            const SizedBox(width: 6),
            Text(
              city,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '$formattedDate $formattedTime',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
