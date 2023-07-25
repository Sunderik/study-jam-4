import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/models/random_fortune_readings_response.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/data/magic_ball_screen_states_enum.dart';

/// Action
class SetMagicBallScreenStatusAction {
  final MagicBallScreenStatusEnum status;

  SetMagicBallScreenStatusAction(this.status);

  @override
  String toString() {
    return '$this{state:$status}';
  }
}

/// Action
class SetRandomFortuneReadingAction {
  final String? reading;

  SetRandomFortuneReadingAction(this.reading);

  @override
  String toString() {
    return '$this{reading: $reading}';
  }
}

/// Action запроса
class SendRandomFortuneReadingsRequestAction {
  SendRandomFortuneReadingsRequestAction();

  @override
  String toString() {
    return '$this';
  }
}

/// Action ответа
class SetRandomFortuneReadingsResponseAction {
  final RandomFortuneReadingsResponse response;

  SetRandomFortuneReadingsResponseAction(this.response);

  @override
  String toString() {
    return '$this{response: $response}';
  }
}
