import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/city_search_bar.dart';
import '../widgets/location_info.dart';
import '../widgets/temperature_display.dart';
import '../widgets/weather_details_card.dart';
import '../widgets/forecast_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final weather = weatherProvider.weatherData;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.grey],
                )
              : null,
          color: isDark ? null : const Color(0xFF4A90E2),
        ),
        child: SafeArea(
          child: weather == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                isDark ? Icons.light_mode : Icons.dark_mode,
                                size: 28,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                themeProvider.toggleTheme();
                              },
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: CitySearchBar(),
                      ),
                      const SizedBox(height: 10),
                      const LocationInfo(),
                      const SizedBox(height: 6),
                      const TemperatureDisplay(),
                      const SizedBox(height: 8),
                      const WeatherDetailsCard(),
                      const ForecastList(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
