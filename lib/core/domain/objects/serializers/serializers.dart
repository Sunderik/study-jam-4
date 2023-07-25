import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/models/random_fortune_readings_response_dto.dart';

part 'serializers.g.dart';

/// Сериализатор моделей приложения
@SerializersFor([
  RandomFortuneReadingsResponseDTO,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
