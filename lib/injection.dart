import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:redux/redux.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/injection.config.dart';

final injector = GetIt.instance;

const _storeType = Store<AppState>;

@InjectableInit(
  ignoreUnregisteredTypes: [Client, _storeType],
)
Future<void> configureInjectionAsync(Environment environment) async {
  await injector.init(environment: environment.name);
}

Future<void> configureTestInjection(Store<AppState>? store) async {
  if (store != null) injector.registerFactory(() => store);
  await injector.init(environment: Env.test.name);
}

abstract class Env {
  static const dev = Environment('dev');
  static const prod = Environment('prod');
  static const test = Environment('test');
}
