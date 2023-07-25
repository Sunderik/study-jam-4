import 'package:built_value/built_value.dart';

part 'base_model.g.dart';

@BuiltValue(instantiable: false)
abstract class BaseModel {
  /// Код ответа от сервера.
  int? get httpCode;
}
