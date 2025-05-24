import 'package:flutter/material.dart';
import '../models/photos.dart';

class PhotoInfoScreen extends StatelessWidget {
  final List<Photos> photos;

  const PhotoInfoScreen({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Информация о фото')),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          final photo = photos[index];
          return ListTile(
            title: Text('ID: ${photo.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Камера: ${photo.camera?.name ?? "Нет данных"}'),
                Text('Марсоход: ${photo.rover?.name ?? "Нет данных"}'),
                Text('Дата на Земле: ${photo.earthDate}'),
              ],
            ),
          );
        },
      ),
    );
  }

  
}