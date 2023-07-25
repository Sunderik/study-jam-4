import 'dart:collection';

import 'package:async/async.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/task.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/thread.dart';

mixin _SchedulerData {
  final threads = <Thread>[];
  final queue = Queue<Task>();
}

abstract class Scheduler with _SchedulerData {
  void manageQueue();

  factory Scheduler() => _SchedulerImpl();
}

class _SchedulerImpl with _SchedulerData implements Scheduler {
  @override
  void manageQueue() {
    if (queue.isNotEmpty) {
      final Thread availableWorker =
          threads.firstWhere((worker) => !worker.isBusy, orElse: () => Thread()); //Todo: поменял null на Thread()

      final task = queue.removeFirst();
      availableWorker.isBusy = true;
      availableWorker.taskId = task.id;
      availableWorker.work(task: task).listen((result) {
        result is ErrorResult
            ? task.completer.completeError(result.error)
            : task.completer.complete(result.asValue!.value);
        manageQueue();
      });
    }
  }
}
