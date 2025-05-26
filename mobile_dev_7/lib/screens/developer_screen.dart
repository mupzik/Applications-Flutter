import 'package:flutter/material.dart';
import 'package:mobile_dev_7/screens/webview_screen.dart';
class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});
  final String articleUrl =
      'https://par-tuman.ru/sferi-primenenia/180-kak-vliyaet-vlazhnost-vozdukha-na-organizm-cheloveka/?srsltid=AfmBOopZw_3ER8YAi87JYlU7-bAVkHr_Qh4FR4ajtwR_6jOnsdNt1Q_Z';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('О разработчике')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: Волосикова Мария', style: TextStyle(fontSize: 20)),
            Text('Группа: ВМК-22', style: TextStyle(fontSize: 16)),
            Text('Электронная почта: mymail@mail.ru .',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(url: articleUrl),
                  ),
                );
              },
              child: Text('Статья о влажности важности'),
            )
          ],
        ),
      ),
    );
  }
}