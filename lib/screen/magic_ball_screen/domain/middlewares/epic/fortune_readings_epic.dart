import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_practice_magic_ball/core/domain/global_state/app_state.dart';
import 'package:surf_practice_magic_ball/core/network/base_epic.dart';
import 'package:surf_practice_magic_ball/core/network/repositories/magic_ball/magic_ball_repository.dart';
import 'package:surf_practice_magic_ball/features/logger/logger.dart';
import 'package:surf_practice_magic_ball/injection.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/actions/magic_ball_screen_actions.dart';

final fortuneReadingsEpics = combineEpics<AppState>([
  injector.get<RandomFortuneReadingsEpic>(),
]);

/// Epic
@Injectable()
class RandomFortuneReadingsEpic extends BaseEpic {
  RandomFortuneReadingsEpic(this._repository);

  final MagicBallRepository _repository;

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return actions.whereType<SendRandomFortuneReadingsRequestAction>().asyncMap((action) {
      return _repository.makeRandomFortuneReadingsRequest(
        timeout: const Duration(seconds: 20),
      );
    }).doOnData((response) {
      response.delay(const Duration(seconds: 3)).listen((value) {
        logger.i('Received Response Body: \n$value');
        appStore.dispatch(SetRandomFortuneReadingsResponseAction(value));
      });
    }).handleError((exception) {
      logger.e(exception.toString());
    });
  }
}
