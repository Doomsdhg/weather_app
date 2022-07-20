import 'package:flutter/material.dart';
import 'package:weather_app/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainPage(title: 'Weather'),
    );
  }
}



