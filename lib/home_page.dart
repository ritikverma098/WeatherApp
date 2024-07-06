import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherApp/service/weather_provider.dart';
import 'package:weatherApp/weather_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider  = Provider.of<WeatherProvider>(context);
    if (weatherProvider.lastSearchedCity.isNotEmpty && _controller.text.isEmpty) {
      _controller.text = weatherProvider.lastSearchedCity;
    }
    return LayoutBuilder(builder: (context,constraint){
      return Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/image/icon.png"),
          title: Row(
            children: [
              SizedBox(
                width: constraint.maxWidth - 136.0,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      labelText: "Enter City Name",
                      focusedBorder: InputBorder.none

                  ),

                ),
              ),
              IconButton(onPressed: (){
                weatherProvider.fetchWeather(_controller.text);
              }, icon: const Icon(Icons.search))
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (weatherProvider.isLoading)
                const CircularProgressIndicator(),
              if (weatherProvider.error.isNotEmpty)
                Text(weatherProvider.error),
              if (weatherProvider.weather != null)
                WeatherDetailsScreen(weather: weatherProvider.weather!),

            ],
          ),
        ),
      );
    });
  }
}
