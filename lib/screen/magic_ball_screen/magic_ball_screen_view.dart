import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/widgets/magic_ball/magic_ball.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/widgets/magic_ball/magic_ball_shadow.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/widgets/main_screen_text.dart';

class MagicBallScreenView extends StatelessWidget {
  const MagicBallScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 6, child: Align(alignment: Alignment.bottomCenter, child: MagicBall())),
          Expanded(flex: 2, child: MagiBallShadow()),
          Expanded(flex: 2, child: MainScreenText())
        ],
      ),
    );
  }
}
