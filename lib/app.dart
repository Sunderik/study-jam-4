import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:surf_practice_magic_ball/app_starter.dart' as starter;
import 'package:surf_practice_magic_ball/core/navigator_key.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/magic_ball_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: starter.store,
      child: MaterialApp(
        navigatorKey: GlobalNavigatorKey.key,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MagicBallScreen(),
      ),
    );
  }
}
