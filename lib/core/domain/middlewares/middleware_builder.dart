import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/core/domain/middlewares/epics.dart';
import 'package:surf_practice_magic_ball/core/domain/middlewares/middlewares.dart';

final List<Middleware<AppState>> allMiddlewares = [...middlewares + epics];
