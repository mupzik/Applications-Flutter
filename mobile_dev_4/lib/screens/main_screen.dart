import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/cubit/main_screen_cubit.dart';
import '/screens/cubit/main_screen_state.dart';

// Класс экрана для отображения калькулятора
class SumScreen extends StatelessWidget {
  const SumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>(); // Ключ для валидации формы
    final _mass = TextEditingController(); // Контроллер для поля ввода a
    final _velocity = TextEditingController(); // Контроллер для поля ввода b

    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор кинетической энергии'), // Заголовок приложения
      ),
      body: BlocBuilder<SumCubit, SumState>(
        builder: (context, state) {
          if (state is SumUpdateState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Поле ввода массы
                    TextFormField(
                      controller: _mass,
                      decoration: const InputDecoration(labelText: 'Масса (кг)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите массу';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Масса должна быть положительным числом';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty && double.tryParse(value) != null) {
                          context.read<SumCubit>().updateNumB(
                                double.parse(value),
                              );
                        }
                      },
                    ),
                    // Поле ввода скорости
                    TextFormField(
                      controller: _velocity,
                      decoration: const InputDecoration(labelText: 'Скорость (м/c)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите скорость';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Скорость должна быть положительным числом';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty && double.tryParse(value) != null) {
                          context.read<SumCubit>().updateNumA(
                                double.parse(value),
                              );
                        }
                      },
                    ),
                    // Чекбокс для согласия на обработку данных
                    CheckboxListTile(
                      title: const Text('Согласен на обработку данных'),
                      value: state.consentChecked,
                      onChanged: (bool? value) {
                        context.read<SumCubit>().updateConsent(value ?? false);
                      },
                    ),
                    // Кнопка для выполнения расчета
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SumCubit>().calculate();
                          if (!state.consentChecked) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Пожалуйста, дайте согласие на обработку данных'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Рассчитать'),
                    ),
                    // Отображение результата, если он есть
                    if (state.result != 0.0) ...[
                      const SizedBox(height: 20),
                        Text(
                              'Кинетическая энергия:',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${state.result} Дж',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                      // Кнопка для сброса данных
                      ElevatedButton(
                        onPressed: () {
                          context.read<SumCubit>().reset();
                          _mass.clear();
                          _velocity.clear();
                        },
                        child: const Text('Сбросить'),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }
          return Container(); // Пустой контейнер, если состояние не определено
        },
      ),
    );
  }
}