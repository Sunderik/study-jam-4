import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/app.dart';
import 'package:surf_practice_magic_ball/app_starter.dart';
import 'package:surf_practice_magic_ball/environments/environments.dart';
import 'package:surf_practice_magic_ball/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Собрать зависимости
  await configureInjectionAsync(Environments.IS_PRODUCTION ? Env.prod : Env.dev);

  // Подготовка к запуску приложения (инициализация хранилища)
  await startApp();

  // Запуск приложения
  runApp(const App());
}
