import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/actions/magic_ball_screen_actions.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/magic_ball_screen_state.dart';

final magicBallScreenReducers = combineReducers<MagicBallScreenState>([
  TypedReducer<MagicBallScreenState, SetMagicBallScreenStatusAction>(_setMagicBallScreenStatus),
  TypedReducer<MagicBallScreenState, SetRandomFortuneReadingAction>(_setRandomFortuneReading),
]);

/// Обработчик события [SetMagicBallScreenStatusAction] передаваемого в параметре [action]
///
/// Изменяет состояние [MagicBallScreenState] полученного из параметра [state]
///
/// Изменяет статус окна в стейте [state],на полученный из [action].
MagicBallScreenState _setMagicBallScreenStatus(MagicBallScreenState state, SetMagicBallScreenStatusAction action) {
  return state.rebuild((b) => b..status = action.status);
}

/// Обработчик события [SetRandomFortuneReadingAction] передаваемого в параметре [action]
///
/// Изменяет состояние [MagicBallScreenState] полученного из параметра [state]
///
/// Изменяет текущее предсказание в стейте [state],на полученное из [action].
MagicBallScreenState _setRandomFortuneReading(MagicBallScreenState state, SetRandomFortuneReadingAction action) {
  return state.rebuild((b) => b..reading = action.reading);
}
