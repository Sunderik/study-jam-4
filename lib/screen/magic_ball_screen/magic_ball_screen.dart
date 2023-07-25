import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/magic_ball_screen_bloc.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/magic_ball_screen_view.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<MagicBallScreenBloc>(
      create: (ctx) => MagicBallScreenBloc()..init(),
      dispose: (ctx, bloc) => bloc.dispose(),
      child: const MagicBallScreenView(),
    );
  }
}
