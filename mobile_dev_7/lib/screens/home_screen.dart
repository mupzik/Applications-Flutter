import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_7/models/weather_model.dart';
import '../cubits/weather_cubit.dart';
import '../screens/developer_screen.dart';
import '../screens/calculations_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeveloperScreen()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              final state = context.read<WeatherCubit>().state;
              WeatherModel? currentWeather;
              if (state is WeatherLoaded && state.currentWeather != null) {
                currentWeather = state.currentWeather;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalculationsScreen(
                    initialWeather: currentWeather,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Введите город',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          context.read<WeatherCubit>().fetchWeather(_controller.text);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                if (state is WeatherLoading)
                  CircularProgressIndicator()
                else if (state is WeatherLoaded && state.currentWeather != null)
                  Column(
                    children: [
                      Text(
                        'Погода в ${state.currentWeather!.city}',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text('Температура: ${state.currentWeather!.temperature}°C'),
                      Text('Влажность: ${state.currentWeather!.humidity}%'),
                      Text('Скорость ветра: ${state.currentWeather!.windSpeed} m/s'),
                      Text('Описание: ${state.currentWeather!.description}'),
                    ],
                  ),
                SizedBox(height: 16),
                Text('История', style: TextStyle(fontSize: 20)),
                Expanded(
                  child: ListView.builder(
                    itemCount: state is WeatherLoaded ? state.history.length : 0,
                    itemBuilder: (context, index) {
                      final weather =
                          (state as WeatherLoaded).history[index];
                      return ListTile(
                        title: Text('${weather.city} - ${weather.description}'),
                        subtitle: Text(
                            '${weather.temperature}°C, ${weather.timestamp}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}