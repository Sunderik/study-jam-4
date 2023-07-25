import 'package:injectable/injectable.dart';

/// Абстарктынй класс конечной точки сервера для обращения
abstract class Endpoint {
  /// Метод создания маршрута для отправки запроса на сервер
  Uri create();
}

abstract class UrlFactory {
  Uri createFor<T extends Endpoint>(T endpoint);
}

@Injectable(as: UrlFactory)
class UrlFactoryManager implements UrlFactory {
  @override
  Uri createFor<T extends Endpoint>(T endpoint) {
    final uri = endpoint.create();

    return uri.replace(scheme: 'https');
  }
}
