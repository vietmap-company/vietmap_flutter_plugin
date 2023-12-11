import 'dart:async';

// Debounce is a class that is used to delay the execution of a function.

class Debounce {
  /// [delay] is the time that the function will be delayed.
  Duration delay;

  /// [_timer] is the timer that is used to delay the execution of a function.
  Timer? _timer;

  Debounce({
    this.delay = const Duration(milliseconds: 500),
  });

  run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}

Future waitWhile(bool Function() test,
    [Duration pollInterval = Duration.zero]) {
  var completer = Completer();
  check() {
    if (test()) {
      completer.complete();
      return true;
    } else {
      Timer(pollInterval, check);
    }
  }

  check();
  return completer.future;
}
