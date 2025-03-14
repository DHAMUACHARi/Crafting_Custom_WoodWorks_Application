import 'dart:ui';

class MultiClick {
  VoidCallback? action;
  int _lastExecutionTime = 0;

  MultiClick({this.action});

  void runForInput(VoidCallback action) {
    _lastExecutionTime = DateTime.now().millisecondsSinceEpoch;
    action();
  }

  void run(VoidCallback action) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime - _lastExecutionTime >= 500) {
      _lastExecutionTime = currentTime;
      action();
    }
  }

  bool runReturn(bool Function() action, bool defaultValue) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime - _lastExecutionTime >= 500) {
      _lastExecutionTime = currentTime;
      return action();
    }
    return defaultValue;
  }
}

