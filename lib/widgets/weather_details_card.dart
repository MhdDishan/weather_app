import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context).weatherData;

    if (weatherData == null) {
      return const Center(
        child: Text('No data available', style: TextStyle(color: Colors.white)),
      );
    }

    final condition = weatherData['weather'][0]['main'];
    final humidity = '${weatherData['main']['humidity']}%';
    final windSpeed = '${weatherData['wind']['speed']} km/h';

    return Column(
      children: [
        const SizedBox(height: 20), 
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _WeatherDetailItem(
                icon: Icons.cloud,
                label: 'Condition',
                value: condition,
              ),
              _WeatherDetailItem(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: humidity,
              ),
              _WeatherDetailItem(
                icon: Icons.air,
                label: 'Wind',
                value: windSpeed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
