import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:weatherApp/service/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsScreen({super.key,required this.weather});

  @override
  Widget build(BuildContext context) {
    final String conditionIconUrl = 'http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.location_city, size: 30),
            const SizedBox(width: 8),
            Text('City: ${weather.areaName}', style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.thermostat, size: 30),
            const SizedBox(width: 8),
            Text('Temperature: ${weather.temperature?.celsius?.toStringAsFixed(1)}°C', style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(conditionIconUrl, width: 50, height: 50),
            const SizedBox(width: 8),
            Text('Condition: ${weather.weatherDescription}', style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.water, size: 30),
            const SizedBox(width: 8),
            Text('Humidity: ${weather.humidity}%', style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.air, size: 30),
            const SizedBox(width: 8),
            Text('Wind Speed: ${weather.windSpeed} m/s', style: const TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Provider.of<WeatherProvider>(context, listen: false).fetchWeather(weather.areaName!);
          },
          child: const Text('Refresh'),
        ),
      ],
    );
  }
}
