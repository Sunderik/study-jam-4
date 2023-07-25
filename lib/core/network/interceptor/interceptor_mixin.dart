import 'package:http/http.dart';

mixin Interceptor {
  BaseRequest intercept(BaseRequest request);
}
