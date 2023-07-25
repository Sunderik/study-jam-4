import 'package:logger/logger.dart';
import 'package:surf_practice_magic_ball/environments/environments.dart';

Logger logger = CustomLogger(
  printer: PrettyPrinter(errorMethodCount: 1, methodCount: 0, printTime: true, colors: true, printEmojis: true),
);

class CustomLogger extends Logger {
  CustomLogger({LogFilter? filter, required LogPrinter printer, LogOutput? output}) : super();

  @override
  Future<void> v(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    if (Environments.IS_PRODUCTION == false) log(Level.verbose, message, error, stackTrace);
  }

  @override
  Future<void> d(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    if (Environments.IS_PRODUCTION == false) log(Level.debug, message, error, stackTrace);
  }

  @override
  Future<void> i(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    if (Environments.IS_PRODUCTION == false) log(Level.info, message, error, stackTrace);
  }

  @override
  Future<void> w(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    if (Environments.IS_PRODUCTION == false) log(Level.warning, message, error, stackTrace);
  }

  @override
  Future<void> e(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    if (Environments.IS_PRODUCTION == false) log(Level.error, message, error, stackTrace);
  }

  @override
  Future<void> wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) async {
    if (Environments.IS_PRODUCTION == false) log(Level.wtf, message, error, stackTrace);
  }
}
