import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/models/random_fortune_readings_response_dto.dart';

import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor([
  RandomFortuneReadingsResponseDTO,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
