import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/core.dart';

List<Middleware<AppState>> createAppMiddleware() {
  return [
    TypedMiddleware<AppState, ClearStoreAction>(_clearStore()),
  ];
}

/// Очистить все хранилище ***[Store]*** приложения.
Middleware<AppState> _clearStore() {
  return (store, action, next) async {};
}
