import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherApp/home_page.dart';
import 'package:weatherApp/service/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context)=>WeatherProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

