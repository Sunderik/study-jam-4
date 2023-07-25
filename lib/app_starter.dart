import 'dart:async';

import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/core.dart';
import 'package:surf_practice_magic_ball/core/domain/middlewares/middleware_builder.dart';
import 'package:surf_practice_magic_ball/core/domain/reducers/reduce_builder.dart';

late Store<AppState> _store;

Store<AppState> get store => _store;

Future<void> startApp() async {
  _store = Store<AppState>(appReducer, initialState: AppState(), middleware: [...allMiddlewares]);
}
