import 'package:built_value/built_value.dart';
import 'package:surf_practice_magic_ball/core/network/models/base_model.dart';

part 'random_fortune_readings_response.g.dart';

abstract class RandomFortuneReadingsResponse
    implements BaseModel, Built<RandomFortuneReadingsResponse, RandomFortuneReadingsResponseBuilder> {
  /// Случайное предсказание
  String? get randomFortuneReading;

  RandomFortuneReadingsResponse._();

  factory RandomFortuneReadingsResponse([void Function(RandomFortuneReadingsResponseBuilder) updates]) =
      _$RandomFortuneReadingsResponse;
}
