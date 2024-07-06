import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherApp/service/open_weather_map.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherFactory _weatherFactory = WeatherFactory(apiKey);
  Weather? _weather;
  bool _isLoading = false;
  String _error = '';
  String _lastSearchedCity = '';

  WeatherProvider() {
    _loadLastSearchedCity();
  }

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get error => _error;
  String get lastSearchedCity => _lastSearchedCity;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _weather = await _weatherFactory.currentWeatherByCityName(city);
      _lastSearchedCity = city;
      await _saveLastSearchedCity(city);
    } catch (e) {
      _error = 'Failed to fetch weather data';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadLastSearchedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastSearchedCity = prefs.getString('lastSearchedCity') ?? '';
    if (_lastSearchedCity.isNotEmpty) {
      await fetchWeather(_lastSearchedCity);
    }
  }

  Future<void> _saveLastSearchedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSearchedCity', city);
  }
}
