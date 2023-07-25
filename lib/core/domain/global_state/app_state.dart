import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:surf_practice_magic_ball/core/domain/objects/serializers/serializers.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/magic_ball_screen_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  factory AppState([void Function(AppStateBuilder)? updates]) {
    return _$AppState((b) => b..magicBallScreenState = MagicBallScreenState().toBuilder());
  }

  MagicBallScreenState get magicBallScreenState;

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AppState.serializer, this) as Map<String, dynamic>;
  }

  static AppState? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AppState.serializer, json);
  }

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
