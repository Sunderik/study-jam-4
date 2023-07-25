import 'dart:async';

import 'package:uuid/uuid.dart';

class Task<I, O> {
  final Function function;
  final Object bundle;
  final Duration timeout;
  final completer = Completer<O>();
  late String id;

  Task({required this.function, required this.bundle, required this.timeout}) {
    id = const Uuid().v4();
  }
}
