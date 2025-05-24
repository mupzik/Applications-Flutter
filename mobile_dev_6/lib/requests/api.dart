import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/photos.dart';

Future<List<Photos>> getNasaData() async {
  final Uri url = Uri.parse(
      'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&api_key=s46BJQAP6Za0Qri6ZskiqRBedMlLdny3gMalC6vV');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body); // получаем Map<String, dynamic>
    final List<dynamic> photosJsonList = data['photos']; // извлекаем список

    // преобразуем каждый элемент в объект Photos
    final List<Photos> photosList = photosJsonList
        .map((itemJson) => Photos.fromJson(itemJson))
        .toList();

    return photosList; 
  } else {
    throw Exception('Ошибка загрузки данных: ${response.reasonPhrase}');
  }
}