import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:surf_practice_magic_ball/core/di/provider/store_provider.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/injection.dart';

abstract class BaseEpic implements EpicClass<AppState> {
  late Store appStore = injector.get<AppStoreProvider>().store;
}
