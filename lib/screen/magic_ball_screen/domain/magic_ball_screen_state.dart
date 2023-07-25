import 'package:built_value/built_value.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/data/magic_ball_screen_states_enum.dart';

part 'magic_ball_screen_state.g.dart';

/// Объект стейта окна магического шара
abstract class MagicBallScreenState implements Built<MagicBallScreenState, MagicBallScreenStateBuilder> {
  /// Состояние окна магического шара
  MagicBallScreenStatusEnum? get status;

  /// Текущее предсказание
  String? get reading;

  MagicBallScreenState._();

  factory MagicBallScreenState([void Function(MagicBallScreenStateBuilder) updates]) = _$MagicBallScreenState;
}
