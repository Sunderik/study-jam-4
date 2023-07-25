import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_practice_magic_ball/core/network/models/rest_bundle.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/endpoints/random_fortune_readings_endpoint.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/models/random_fortune_readings_response_dto.dart';
import 'package:surf_practice_magic_ball/core/network/services/rest_service/rest_service.dart';
import 'package:surf_practice_magic_ball/core/network/url_factory.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/isolate_manager_mixin.dart';

import 'bundles/random_fortune_readings_bundle.dart';
import 'models/random_fortune_readings_response.dart';

abstract class MagicBallRepository {
  /// Запрос на получение исполнителя проекта.
  Stream<RandomFortuneReadingsResponse> makeRandomFortuneReadingsRequest({Duration timeout});
}

@Injectable(as: MagicBallRepository, env: [Environment.prod])
class MagicBallRepositoryImpl with IsolateManagerMixin implements MagicBallRepository {
  late final IRestService _restService;
  late final UrlFactory _urlFactory;

  MagicBallRepositoryImpl(this._restService, this._urlFactory);

  @override
  Stream<RandomFortuneReadingsResponse> makeRandomFortuneReadingsRequest(
      {Duration timeout = const Duration(seconds: 5)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<RandomFortuneReadingsResponseDTO>();
    subscribe(inputSubject, outputSubject, randomFortuneReadingsMapRestBundle);
    _makeRandomFortuneReadingsRequest(
      input: inputSubject,
      output: outputSubject,
      timeout: timeout,
    );
    var result = outputSubject.map<RandomFortuneReadingsResponse>((output) => output.fromDTO());
    return result;
  }

  /// Выполнение запроса в методе [makeTeamExecutorInfoRequest].
  void _makeRandomFortuneReadingsRequest({
    required BehaviorSubject<RestBundle> input,
    required BehaviorSubject<RandomFortuneReadingsResponseDTO> output,
    required Duration timeout,
  }) {
    final endpoint = RandomFortuneReadingsEndpoint();
    final url = _urlFactory.createFor<RandomFortuneReadingsEndpoint>(endpoint);
    executeGetRestRequest(input, output, _restService, url, RandomFortuneReadingsResponseDTO.serializer, timeout);
  }
}

@Injectable(as: MagicBallRepository, env: [Environment.dev])
class MagicBallRepositoryMockImpl implements MagicBallRepository {
  MagicBallRepositoryMockImpl();

  @override
  Stream<RandomFortuneReadingsResponse> makeRandomFortuneReadingsRequest(
      {Duration timeout = const Duration(seconds: 5)}) {
    var controller = StreamController<RandomFortuneReadingsResponse>();

    controller.add(RandomFortuneReadingsResponse((b) => b
      ..randomFortuneReading = "Lucky test message"
      ..httpCode = 200));
    return controller.stream;
  }
}
