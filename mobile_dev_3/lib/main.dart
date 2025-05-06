import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор кинетической энергии',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

// Первый экран
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  double? _mass;
  double? _velocity;
  bool _isAgreed = false;

  void _calculateKineticEnergy() {
    if (_formKey.currentState!.validate() && _isAgreed) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            mass: _mass!,
            velocity: _velocity!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля и согласитесь на обработку данных')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор кинетической энергии'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Масса (кг)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите массу';
                  }
                  final mass = double.tryParse(value);
                  if (mass == null || mass <= 0) {
                    return 'Масса должна быть положительным числом';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mass = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Скорость (м/с)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите скорость';
                  }
                  final velocity = double.tryParse(value);
                  if (velocity == null || velocity <= 0) {
                    return 'Скорость должна быть положительным числом';
                  }
                  return null;
                },
                onSaved: (value) {
                  _velocity = double.parse(value!);
                },
              ),
              CheckboxListTile(
                title: Text('Согласен на обработку данных'),
                value: _isAgreed,
                onChanged: (value) {
                  setState(() {
                    _isAgreed = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _calculateKineticEnergy();
                  }
                },
                child: Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Второй экран
class SecondScreen extends StatelessWidget {
  final double mass;
  final double velocity;

  SecondScreen({required this.mass, required this.velocity});

  double get kineticEnergy {
    return 0.5 * mass * velocity * velocity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результат расчета'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Кинетическая энергия:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '${kineticEnergy.toStringAsFixed(2)} Дж',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}