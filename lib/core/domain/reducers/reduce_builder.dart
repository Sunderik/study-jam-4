import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/magic_ball_screen_reducers.dart';

///Все обработчики событий приложения
AppState appReducer(AppState state, action) {
  return state.rebuild(
      (b) => b..magicBallScreenState = magicBallScreenReducers(state.magicBallScreenState, action).toBuilder());
}
