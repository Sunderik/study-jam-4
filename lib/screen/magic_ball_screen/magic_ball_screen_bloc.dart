import 'dart:async';

import 'package:surf_practice_magic_ball/core/core.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/data/magic_ball_screen_states_enum.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen/domain/actions/magic_ball_screen_actions.dart';

/// Объект бизнес-логики
class MagicBallScreenBloc extends BaseBloc {
  @override
  void init() {
    super.init();
    _initCurrentScreenStatus();
    _initCurrentRandomReading();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeCurrentScreenStatus();
    _disposeCurrentRandomReading();
  }

  //#region Screen Status Section

  ///
  MagicBallScreenStatusEnum? get currentScreenStatus => store.state.magicBallScreenState.status;

  /// Поток контроллера для
  Stream<MagicBallScreenStatusEnum?>? get currentScreenStatusStream => _currentScreenStatusController?.stream;

  /// Контроллер
  StreamController<MagicBallScreenStatusEnum?>? _currentScreenStatusController;

  /// Подписка
  StreamSubscription<MagicBallScreenStatusEnum?>? _currentScreenStatusSubscription;

  /// Инициализирует подписку, контроллер и селектор для
  void _initCurrentScreenStatus() {
    // Подписка на изменение настроек текущего пользователя
    _currentScreenStatusController = StreamController<MagicBallScreenStatusEnum?>.broadcast();
    _currentScreenStatusSubscription =
        store.onChange.map((state) => state.magicBallScreenState.status).distinct().listen((status) {
      if (status != null) {
        _currentScreenStatusController?.sink.add(status);
      }
    });

    store.dispatch(SetMagicBallScreenStatusAction(MagicBallScreenStatusEnum.waiting));
  }

  /// Закрывает подписку и контроллер для
  void _disposeCurrentScreenStatus() {
    _currentScreenStatusController?.close();
    _currentScreenStatusSubscription?.cancel();
  }

  //#endregion

  //#region Random Reading Section

  ///
  String? get currentRandomReading => store.state.magicBallScreenState.reading;

  /// Поток контроллера
  Stream<String?>? get currentRandomReadingStream => _currentRandomReadingController?.stream;

  /// Контроллер
  StreamController<String?>? _currentRandomReadingController;

  /// Подписка
  StreamSubscription<String?>? _currentRandomReadingSubscription;

  /// Инициализирует подписку, контроллер и селектор для
  void _initCurrentRandomReading() {
    // Подписка на изменение настроек текущего пользователя
    _currentRandomReadingController = StreamController<String?>.broadcast();
    _currentRandomReadingSubscription =
        store.onChange.map((state) => state.magicBallScreenState.reading).distinct().listen((reading) {
      if (reading != null) {
        _currentRandomReadingController?.sink.add(reading);
      }
    });
  }

  /// Закрывает подписку и контроллер для
  void _disposeCurrentRandomReading() {
    _currentRandomReadingController?.close();
    _currentRandomReadingSubscription?.cancel();
  }

  //#endregion

  /// Отправить запрос на получение предсказания
  void sendRandomFortuneReadingsRequest() {
    store
      ..dispatch(SetMagicBallScreenStatusAction(MagicBallScreenStatusEnum.init))
      ..dispatch(SendRandomFortuneReadingsRequestAction());
  }
}
