import 'dart:convert';

import 'package:surf_practice_magic_ball/core/domain/objects/serializers/serializers.dart';
import 'package:surf_practice_magic_ball/core/network/models/rest_bundle.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/models/random_fortune_readings_response_dto.dart';
import 'package:surf_practice_magic_ball/features/logger/logger.dart';

/// Конвертация ответа от сервера в модель [TeamMemberDesignEngineerDetailsResponse].
RandomFortuneReadingsResponseDTO randomFortuneReadingsMapRestBundle(RestBundle bundle) {
  if (bundle.status != 200) {
    return RandomFortuneReadingsResponseDTO((builder) => builder..httpCode = bundle.status);
  }
  try {
    final jsonDecoded = jsonDecode(bundle.data ?? '');
    final RandomFortuneReadingsResponseDTO response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } on Exception catch (err) {
    logger.e('randomFortuneReadingsMapRestBundle $err');
    return RandomFortuneReadingsResponseDTO((builder) => builder.httpCode = bundle.status);
  }
}
