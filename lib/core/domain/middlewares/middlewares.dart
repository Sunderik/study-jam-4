import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/core/domain/middlewares/domain_middlewares/app_middleware.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/middlewares/team_member_details_middleware.dart';

final List<Middleware<AppState>> middlewares = [
  ...createAppMiddleware(),
  ...createFortuneReadingsMiddleware(),
];
