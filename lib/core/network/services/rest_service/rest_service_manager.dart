part of rest_service;

/// Реализация сервиса запросов под мобильную платформу
@Injectable(as: IRestService)
class RestServiceManager implements IRestService {
  final Client client;

  RestServiceManager(this.client);

  @override
  Map<int, Interceptor> interceptors = {
    1: CORSInterceptor(),
  };

  bool _isLoggingEnabled = true;

  @override
  void setLoggingEnabled({required bool isEnabled, bool? stripBody}) {
    _isLoggingEnabled = isEnabled;
  }

  @override
  void addInterceptor(int order, Interceptor interceptor) {
    interceptors.putIfAbsent(order, () => interceptor);
  }

  @override
  void removeInterceptor(Interceptor interceptor) {
    interceptors.removeWhere((key, value) => value == interceptor);
  }

  @override
  void interceptRequest(BaseRequest request) {
    try {
      interceptors.keys.toList()
        ..sort()
        ..forEach((key) => interceptors[key]!.intercept(request));
    } on Exception catch (error, stackTrace) {
      logger.e('Error in _interceptRequest', error, stackTrace);
      rethrow;
    }
  }

  @override
  Future<RESP> getStringRequest<RESP>(
    Uri path, {
    Map<String, dynamic>? queryParameters,
    Serializer? deserializer,
    Map<String, String>? headers,
  }) async {
    final request = Request(methodGet, path);
    interceptRequest(request);

    headers?.forEach((key, update) {
      request.headers.update(key, (value) => update, ifAbsent: () => update);
    });

    if (_isLoggingEnabled) {
      unawaited(printRequestLog(methodGet, request));
    }

    final response = await Response.fromStream(
      await client.send(request).catchError(
        (error, stackTrace) {
          logger.e('Error in getStringRequest', error, stackTrace);
          throw error;
        },
      ),
    );

    if (_isLoggingEnabled) {
      unawaited(printResponseLog(methodGet, response));
    }

    if (deserializer != null) {
      return serializers.deserializeWith(deserializer, jsonDecode(response.body)) as RESP;
    } else {
      return response as RESP;
    }
  }

  @override
  Future<RESP> get<RESP>(
    Uri path, {
    Map<String, dynamic>? queryParameters,
    Serializer? deserializer,
    Map<String, String>? headers,
  }) async {
    final request = Request(methodGet, path);
    interceptRequest(request);

    if (_isLoggingEnabled) {
      unawaited(printRequestLog(methodGet, request));
    }
    final response = await Response.fromStream(
      await client.send(request).catchError(
        (error, stackTrace) {
          logger.e('Error in get', error, stackTrace);
          throw error;
        },
      ),
    );

    if (_isLoggingEnabled) {
      unawaited(printResponseLog(methodGet, response));
    }

    if (deserializer != null) {
      return serializers.deserializeWith(deserializer, jsonDecode(response.body)) as RESP;
    } else {
      return response as RESP;
    }
  }
}
