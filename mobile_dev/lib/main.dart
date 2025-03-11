// dev: Волосикова М.А. ВМК-22
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Лабораторная работа №2. Волосикова Мария Алексеевна'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override

  // размер самого малого контейнера
  double size = 100;

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


            Stack(
              alignment: Alignment.center,
              children: [

                // Размер контейнеров задается размером самого маленького контейнера (последнего в стеке: purple)
                // и увеличивается пропорционально
                Container(color: Colors.red,        width: size * 7, height: size * 7),
                Container(color: Colors.orange,     width: size * 6, height: size * 6),
                Container(color: Colors.yellow,     width: size * 5, height: size * 5),
                Container(color: Colors.green,      width: size * 4, height: size * 4),
                Container(color: Colors.lightBlue,  width: size * 3, height: size * 3),
                Container(color: Colors.blue,       width: size * 2, height: size * 2),
                Container(color: Colors.purple,     width: size,     height: size),
              ],
            ),




        ],
      ),
    );
  }
}
