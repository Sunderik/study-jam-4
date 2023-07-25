import 'package:surf_practice_magic_ball/core/network/url_factory.dart';
import 'package:surf_practice_magic_ball/core/network/urls.dart';

/// Эндпоинт на получение случайного предсказания
class RandomFortuneReadingsEndpoint implements Endpoint {
  @override
  Uri create() {
    return Uri.https(Urls.serverURL, Urls.randomFortuneReadings);
  }
}
