import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_dev_6/requests/api.dart';
import 'dart:convert';
import '../models/photos.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Photos>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = getNasaData();
  }

 
  // Метод для отображения деталей фотографии в виде диалога
  void _showPhotoDetails(BuildContext context, Photos photo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Детали фотографии',
          style: TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${photo.id ?? 'Н/Д'}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Дата на Земле: ${photo.earthDate ?? 'Н/Д'}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Камера: ${photo.camera?.fullName ?? 'Н/Д'}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Марсоход: ${photo.rover?.name ?? 'Н/Д'}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Статус марсохода: ${photo.rover?.status ?? 'Н/Д'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Закрыть',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Фото Curiosity (сол: 100). Волосикова Мария, ВМК-22')),
      body: FutureBuilder<List<Photos>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final photo = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    _showPhotoDetails(context, photo); // Теперь здесь показываем диалог
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            photo.imgSrc ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Камера: ${photo.camera?.name ?? "Нет данных"}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('ID: ${photo.id}'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}