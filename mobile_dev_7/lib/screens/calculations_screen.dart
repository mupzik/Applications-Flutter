import 'package:flutter/material.dart';
import 'package:mobile_dev_7/models/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculationsScreen extends StatefulWidget {
  final WeatherModel? initialWeather;

  const CalculationsScreen({super.key, this.initialWeather});

@override
CalculationsScreenState createState() => CalculationsScreenState();
}


class CalculationsScreenState extends State<CalculationsScreen> {
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  String _comfortLevel = '';
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    
    _loadHistory();
    // Предзаполнение полей, если есть данные о погоде
    if (widget.initialWeather != null) {
      _tempController.text = widget.initialWeather!.temperature.toString();
      _humidityController.text = widget.initialWeather!.humidity.toString();
      _calculateAndSaveComfort(
        widget.initialWeather!.temperature,
        widget.initialWeather!.humidity,
      );
    }
  }

  void _calculateAndSaveComfort(double temperature, double humidity) {
    final comfort = _calculateComfort(temperature, humidity);
    final fahrenheit = _celsiusToFahrenheit(temperature);
    setState(() {
      _comfortLevel = comfort;
    });
    _saveHistory(
        'Температура: $temperature°C ($fahrenheit°F), Влажность: $humidity%, Комфорт: $comfort');
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _history = prefs.getStringList('calc_history') ?? [];
    });
  }

  Future<void> _saveHistory(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    _history.add(entry);
    await prefs.setStringList('calc_history', _history);
    setState(() {});
  }

  String _calculateComfort(double temperature, double humidity) {
    if (humidity < 30) return 'Слишком сухо';
    if (humidity > 70) return 'Слишком влажно';
    if (temperature < 18) return 'Слишком холодно';
    if (temperature > 26) return 'Слишком жарко';
    return 'Восхитительно средние показатели!';
  }

  double _celsiusToFahrenheit(double celsius) => celsius * 9 / 5 + 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вычисления')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tempController,
              decoration: InputDecoration(labelText: 'Температура (°C)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _humidityController,
              decoration: InputDecoration(labelText: 'Влажность (%)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final temp = double.tryParse(_tempController.text);
                final humidity = double.tryParse(_humidityController.text);
                if (temp != null && humidity != null) {
                  _calculateAndSaveComfort(temp, humidity);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Принимаем числа')),
                  );
                }
              },
              child: Text('Вычислить'),
            ),
            SizedBox(height: 16),
            Text('Комфортность: $_comfortLevel', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text('Вычисления', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_history[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}