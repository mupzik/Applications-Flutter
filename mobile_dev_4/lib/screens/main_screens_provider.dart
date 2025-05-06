import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/cubit/main_screen_cubit.dart';
import '/screens/main_screen.dart';

// Класс провайдера для предоставления Cubit экрану
class MainScreenProvider extends StatelessWidget {
  const MainScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SumCubit>(
      create: (context) => SumCubit(), // Создание экземпляра Cubit
      child: const SumScreen(), // Передача экрана как дочернего виджета
    );
  }
}