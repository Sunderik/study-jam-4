import 'dart:async';

import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/scheduler.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/task.dart';
import 'package:surf_practice_magic_ball/core/utilities/isolate_manager/thread.dart';

enum WorkPriority { high, low }

enum Policy { fifo }

abstract class IsolateExecutor {
  Future<void>? warmUp();

  Stream<O> addTask<I, O>({required Task<I, O> task, WorkPriority priority = WorkPriority.high});

  void removeTask({required Task task});

  void stop();

  factory IsolateExecutor({int threadPoolSize = 1}) => _IsolateManager(threadPoolSize: threadPoolSize);

  factory IsolateExecutor.fake() => _FakeIsolateExecutor();

  factory IsolateExecutor.fifo() => _IsolateManager()..threadPoolSize = 1;
}

class _IsolateManager implements IsolateExecutor {
  int? threadPoolSize;
  final _scheduler = Scheduler();

  static final _IsolateManager _manager = _IsolateManager._internal();

  factory _IsolateManager({threadPoolSize = 1}) {
    if (_manager.threadPoolSize == null) {
      _manager.threadPoolSize = threadPoolSize;
      for (var i = 0; i < _manager.threadPoolSize!; i++) {
        _manager._scheduler.threads.add(Thread());
      }
    }
    return _manager;
  }

  _IsolateManager._internal();

  @override
  Future<void>? warmUp() async => await Future.wait(_scheduler.threads.map((thread) => thread.initPortConnection()));

  @override
  Stream<O> addTask<I, O>({Task? task, WorkPriority priority = WorkPriority.high}) {
    priority == WorkPriority.high ? _scheduler.queue.addFirst(task!) : _scheduler.queue.addLast(task!);
    if (_scheduler.queue.length == 1) _scheduler.manageQueue();
    return Stream.fromFuture(task.completer.future) as Stream<O>;
  }

  @override
  void removeTask({Task? task}) {
    if (_scheduler.queue.contains(task)) _scheduler.queue.remove(task);
    for (final thread in _scheduler.threads) {
      if (thread.taskId == task!.id) {
        task.completer.completeError('task closed');
        thread.cancel();
        _scheduler.threads.remove(thread);
        _scheduler.threads.add(Thread());
      }
    }
  }

  @override
  void stop() {
    for (final thread in _scheduler.threads) {
      thread.cancel();
    }
    _scheduler.threads.clear();
    _scheduler.queue.clear();
  }
}

class _FakeIsolateExecutor implements IsolateExecutor {
  final _scheduler = Scheduler();

  @override
  Future<void>? warmUp() {
    return null;
  }

  @override
  void removeTask({Task? task}) {
    if (_scheduler.queue.contains(task)) _scheduler.queue.remove(task);
  }

  @override
  void stop() {}

  @override
  Stream<O> addTask<I, O>({Task<I, O>? task, WorkPriority priority = WorkPriority.high}) {
    return Stream.value(task!.function(task.bundle));
  }
}
