import 'package:injectable/injectable.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/app_starter.dart' as starter;
import 'package:surf_practice_magic_ball/core/domain/domain.dart';

abstract class AppStoreProvider {
  Store<AppState> get store;
}

@Injectable(as: AppStoreProvider, env: [Environment.dev, Environment.prod])
class StoreProviderImpl implements AppStoreProvider {
  @override
  Store<AppState> get store => starter.store;
}

@Injectable(as: AppStoreProvider, env: [Environment.test])
class MockStoreProviderImpl extends Mock implements AppStoreProvider {
  final Store<AppState> _store;

  MockStoreProviderImpl(this._store);

  @override
  Store<AppState> get store => _store;
}
