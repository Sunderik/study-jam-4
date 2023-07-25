import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/data/magic_ball_screen_states_enum.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/actions/magic_ball_screen_actions.dart';

List<Middleware<AppState>> createFortuneReadingsMiddleware() {
  return [
    TypedMiddleware<AppState, SendRandomFortuneReadingsRequestAction>(_sendRandomFortuneReadingsRequest()),
    TypedMiddleware<AppState, SetRandomFortuneReadingsResponseAction>(_setRandomFortuneReadingsResponse()),
  ];
}

/// Запрос
Middleware<AppState> _sendRandomFortuneReadingsRequest() {
  return (store, action, next) async {
    next(action);

    store
      ..dispatch(SetRandomFortuneReadingAction(null))
      ..dispatch(SetMagicBallScreenStatusAction(MagicBallScreenStatusEnum.loading));
  };
}

///
Middleware<AppState> _setRandomFortuneReadingsResponse() {
  return (store, action, next) async {
    next(action);

    ///
    final response = (action as SetRandomFortuneReadingsResponseAction).response;
    switch (response.httpCode) {
      case 200:
        store
          ..dispatch(SetRandomFortuneReadingAction(response.randomFortuneReading))
          ..dispatch(SetMagicBallScreenStatusAction(MagicBallScreenStatusEnum.waiting));
        break;
      default:
        {
          store
            ..dispatch(SetRandomFortuneReadingAction(null))
            ..dispatch(SetMagicBallScreenStatusAction(MagicBallScreenStatusEnum.error));
        }
    }
  };
}
