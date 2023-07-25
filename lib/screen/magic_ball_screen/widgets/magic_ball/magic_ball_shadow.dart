import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/core/animation/animate.dart';
import 'package:surf_practice_magic_ball/core/animation/effects/scale_effect.dart';
import 'package:surf_practice_magic_ball/core/animation/extensions/extensions.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/data/magic_ball_screen_states_enum.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/magic_ball_screen_bloc.dart';

class MagiBallShadow extends StatefulWidget {
  const MagiBallShadow({super.key});

  @override
  State<MagiBallShadow> createState() => _MagiBallShadowState();
}

class _MagiBallShadowState extends State<MagiBallShadow> {
  @override
  Widget build(BuildContext context) {
    MagicBallScreenBloc bloc = Provider.of<MagicBallScreenBloc>(context, listen: false);
    return Center(
      child: StreamBuilder<MagicBallScreenStatusEnum?>(
        stream: bloc.currentScreenStatusStream,
        builder: (context, snapshot) {
          final status = bloc.currentScreenStatus;
          return Stack(
            children: [
              if (status != null && status == MagicBallScreenStatusEnum.error)
                const Align(
                  child: Image(
                    image: AssetImage('assets/images/error_shadow_2.png'),
                  ),
                ),
              if (status != null && status == MagicBallScreenStatusEnum.error)
                const Align(
                  child: Image(
                    image: AssetImage('assets/images/error_shadow_1.png'),
                  ),
                ),
              if (status != null && status != MagicBallScreenStatusEnum.error)
                const Align(
                  child: Image(
                    image: AssetImage('assets/images/normal_shadow_2.png'),
                  ),
                ),
              if (status != null && status != MagicBallScreenStatusEnum.error)
                const Align(
                  child: Image(
                    image: AssetImage('assets/images/normal_shadow_1.png'),
                  ),
                ),
            ],
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                  begin: const Offset(0.2, 0.2),
                  end: const Offset(0.8, 0.8),
                  delay: 1.seconds,
                  duration: 4.seconds,
                  curve: Curves.linear)
              .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(0.2, 0.2),
                  delay: 1.seconds,
                  duration: 4.seconds,
                  curve: Curves.linear);
        },
      ),
    );
  }
}
