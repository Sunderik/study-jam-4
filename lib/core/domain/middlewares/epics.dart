import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/middlewares/epic/fortune_readings_epic.dart';

final List<Middleware<AppState>> epics = [
  EpicMiddleware<AppState>(fortuneReadingsEpics),
];
