import 'dart:async';

class TimerManager {
  Timer? _timer;
  int _elapsedSeconds = 0;
  Function(int)? onTick;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _elapsedSeconds++;
      if (onTick != null) onTick!(_elapsedSeconds);
    });
  }

  void stop() {
    _timer?.cancel();
    _elapsedSeconds = 0;
  }

  void pause() {
    _timer?.cancel();
  }

  int get elapsedSeconds => _elapsedSeconds;
}
