import 'package:http/http.dart';
import 'package:surf_practice_magic_ball/core/network/interceptor/interceptor_mixin.dart';

const accessForAll = '*';

/// Интерцептор для исключения ошибок CORS-а
class CORSInterceptor implements Interceptor {
  @override
  BaseRequest intercept(BaseRequest request) {
    request.headers.update('Access-Control-Allow-Origin', (update) => accessForAll, ifAbsent: () => accessForAll);
    request.headers.update('Access-Control-Allow-Headers', (update) => accessForAll, ifAbsent: () => accessForAll);
    request.headers.update('Access-Control-Allow-Methods', (update) => accessForAll, ifAbsent: () => accessForAll);

    return request;
  }

  @override
  String toString() {
    return '$runtimeType';
  }
}
