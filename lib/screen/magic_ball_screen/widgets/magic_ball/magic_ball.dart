import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/core/animation/animate.dart';
import 'package:surf_practice_magic_ball/core/animation/effects/effects.dart';
import 'package:surf_practice_magic_ball/core/animation/extensions/extensions.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/magic_ball_screen_bloc.dart';

import '../../data/magic_ball_screen_states_enum.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  @override
  Widget build(BuildContext context) {
    MagicBallScreenBloc bloc = Provider.of<MagicBallScreenBloc>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: StreamBuilder<MagicBallScreenStatusEnum?>(
              stream: bloc.currentScreenStatusStream,
              builder: (context, snapshot) {
                final status = bloc.currentScreenStatus;
                if (status != null) {
                  return Stack(children: [
                    const Center(
                        child: Image(
                      image: AssetImage('assets/images/ball.png'),
                      fit: BoxFit.fitWidth,
                    )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: CircleAvatar(
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          radius: double.maxFinite,
                          child: GestureDetector(
                            onTap: bloc.sendRandomFortuneReadingsRequest,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Stack(children: [
                                if (status == MagicBallScreenStatusEnum.loading)
                                  Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          radius: 1,
                                          colors: [Colors.white, Colors.white10, Colors.transparent],
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate(onInit: (controller) => controller.reset())
                                      .fade(begin: 0, end: 1, duration: 3.seconds),
                                if (status == MagicBallScreenStatusEnum.error)
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          radius: 1,
                                          colors: [Colors.red, Colors.red.withOpacity(0.1), Colors.transparent],
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate(onInit: (controller) => controller.reset())
                                      .fade(begin: 0, end: 1, duration: 3.seconds),
                                StreamBuilder<String?>(
                                    stream: bloc.currentRandomReadingStream,
                                    builder: (context, snapshot) {
                                      final reading = bloc.currentRandomReading;
                                      if (reading != null && reading.isNotEmpty) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                              reading,
                                              style: Theme.of(context).textTheme.titleLarge,
                                              textAlign: TextAlign.center,
                                            ))),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])
                      .animate(onPlay: (controller) => controller.repeat())
                      .shakeY(hz: 0.2, curve: Curves.linear, duration: 10.seconds);
                } else {
                  return Container();
                }
              }),
        ));
  }
}
