import 'package:flutter/material.dart';
import '/screens/main_screens_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор кинетической энергии - Волосикова Мария, ВМК-22',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreenProvider(), // Используем провайдер Cubit
    );
  }
}