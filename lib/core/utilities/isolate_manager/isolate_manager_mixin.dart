import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_practice_magic_ball/core/core.dart' hide Task;
import 'package:surf_practice_magic_ball/core/network/models/rest_bundle.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/isolate_executor.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/task.dart';
import 'package:surf_practice_magic_ball/features/logger/logger.dart';

/// Мнеджер выполнения задачи в отдельном потоке (не основном потоке приложения)
///
/// Для приложения используется отдельный изолят
///
/// Для сайта используется функция compute
mixin IsolateManagerMixin {
  void subscribe<I, O>(Stream input, Subject output, Function function) {
    input.listen((bundle) {
      if (!kIsWeb) {
        final task =
            Task<I, O>(bundle: bundle, function: function, timeout: bundle.timeout ?? const Duration(seconds: 20));
        IsolateExecutor().addTask<I, O>(task: task).listen(output.add).onError((err) {
          logger.e('onError $err');
          output.addError(err);
        });
      } else {
        dynamic _subFunc(dynamic bundle) {
          return function(bundle);
        }

        compute(_subFunc, bundle).then((value) => output.add(value)).catchError((err) {
          logger.e('onError $err');
          output.addError(err);
        });
      }
    });
  }

  void executeGetRestRequest(
      Subject input, Subject output, IRestService service, Uri uri, Serializer serializer, Duration? timeout,
      {String? key, Map<String, String>? headers}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key,
          data: response?.body,
          bodyBytes: response?.bodyBytes,
          serializer: serializer,
          timeout: timeout,
          status: response?.statusCode));
    }

    final requestFuture = service
        .get(
      uri,
      headers: headers,
    )
        .catchError((err) {
      output.addError(err);
    });
    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((err) {
      logger.e('requestFuture.catchError $err $uri');
      output.addError(err);
    });
  }

  void executeRestGetStringRequest(
      Subject input, Subject output, IRestService service, Uri uri, Serializer serializer, Duration? timeout,
      {String? key, Map<String, String>? headers}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key,
          data: response?.body,
          bodyBytes: response?.bodyBytes,
          serializer: serializer,
          timeout: timeout,
          status: response?.statusCode));
    }

    final requestFuture = service
        .getStringRequest(
      uri,
      queryParameters: null,
      deserializer: null,
      headers: headers,
    )
        .catchError((Object err) {
      output.addError(err);
    });

    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((Object err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((Object err) {
      logger.e('requestFuture.catchError $err $uri');
      output.addError(err);
    });
  }
}
