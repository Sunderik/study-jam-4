import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:surf_practice_magic_ball/core/domain/objects/serializers/serializers.dart';
import 'package:surf_practice_magic_ball/core/network/models/base_model.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/models/random_fortune_readings_response.dart';

part 'random_fortune_readings_response_dto.g.dart';

abstract class RandomFortuneReadingsResponseDTO
    implements BaseModel, Built<RandomFortuneReadingsResponseDTO, RandomFortuneReadingsResponseDTOBuilder> {
  /// Случайное предсказание
  String? get reading;

  RandomFortuneReadingsResponseDTO._();

  factory RandomFortuneReadingsResponseDTO([void Function(RandomFortuneReadingsResponseDTOBuilder) updates]) =
      _$RandomFortuneReadingsResponseDTO;

  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(RandomFortuneReadingsResponseDTO.serializer, this) as Map<String, dynamic>;
  }

  static RandomFortuneReadingsResponseDTO? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(RandomFortuneReadingsResponseDTO.serializer, json);
  }

  static Serializer<RandomFortuneReadingsResponseDTO> get serializer => _$randomFortuneReadingsResponseDTOSerializer;

  RandomFortuneReadingsResponse fromDTO() {
    return RandomFortuneReadingsResponse((b) => b
      ..randomFortuneReading = reading
      ..httpCode = httpCode);
  }
}
