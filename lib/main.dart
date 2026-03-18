import 'package:flutter/material.dart';
import 'package:weather_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clime Weather app',
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
