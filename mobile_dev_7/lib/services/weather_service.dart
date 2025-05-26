import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'fc89bc45c861731b3338fb16a6752a8c'; // Замените на ваш API-ключ
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel(
        city: data['name'],
        temperature: data['main']['temp'].toDouble(),
        humidity: data['main']['humidity'].toDouble(),
        windSpeed: data['wind']['speed'].toDouble(),
        description: data['weather'][0]['description'],
        timestamp: DateTime.now(),
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}