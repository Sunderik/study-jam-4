library rest_service;

import 'dart:async';
import 'dart:convert';

import 'package:built_value/serializer.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_practice_magic_ball/core/domain/objects/serializers/serializers.dart';
import 'package:surf_practice_magic_ball/core/network/interceptor/cors_interceptor.dart';
import 'package:surf_practice_magic_ball/core/network/interceptor/interceptor_mixin.dart';
import 'package:surf_practice_magic_ball/features/logger/logger.dart';

part 'log.dart';
part 'rest_service_manager.dart';

const methodGet = 'GET';

/// Интерфейс сервиса запросов
abstract class IRestService {
  Map<int, Interceptor> get interceptors;

  void addInterceptor(int order, Interceptor interceptor);

  void removeInterceptor(Interceptor interceptor);

  void interceptRequest(BaseRequest request);

  Future<RESP> get<RESP>(
    Uri path, {
    Map<String, dynamic>? queryParameters,
    Serializer? deserializer,
    Map<String, String>? headers,
  });

  Future<RESP> getStringRequest<RESP>(
    Uri path, {
    Map<String, dynamic>? queryParameters,
    Serializer? deserializer,
    Map<String, String>? headers,
  });

  void setLoggingEnabled({required bool isEnabled, bool stripBody});
}
