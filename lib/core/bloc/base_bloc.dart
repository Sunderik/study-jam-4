import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/di/provider/store_provider.dart';
import 'package:surf_practice_magic_ball/core/domain/domain.dart';
import 'package:surf_practice_magic_ball/injection.dart';

/// Базовый объект бизнес-логики для окна
abstract class BaseBloc {
  /// Свойство получения доступа к глобальному состоянию приложения через DI.
  final AppStoreProvider _storeProvider = injector.get<AppStoreProvider>();

  /// Селектор для получения доступа к глобальному состоянию приложения.
  Store<AppState> get store => _storeProvider.store;

  ///Метод инициализации блока,вызывается  через провайдер в дереве виджитов при построении ветви дерева.
  @mustCallSuper
  void init() {}

  ///Метод хакрытия блока,вызывается при через провайдер в дереве виджитов  при стирании ветви дерева
  @mustCallSuper
  void dispose() {}
}
