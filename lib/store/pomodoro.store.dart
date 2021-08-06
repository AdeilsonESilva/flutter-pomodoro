import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum IntervalType { WORK, REST }

abstract class _PomodoroStore with Store {
  @observable
  bool started = false;

  @observable
  int minutes = 2;

  @observable
  int seconds = 0;

  @observable
  int timeWork = 2;

  @observable
  int timeRest = 1;

  @observable
  IntervalType intervalType = IntervalType.WORK;

  Timer? _timer;
  int _timerValue = 1000;

  @action
  void incTimeWork() {
    timeWork++;
    if (isWork()) {
      restart();
    }
  }

  @action
  void decTimeWork() {
    if (timeWork > 1) {
      timeWork--;
    }
    if (isWork()) {
      restart();
    }
  }

  @action
  void incTimeRest() {
    timeRest++;
    if (isRest()) {
      restart();
    }
  }

  @action
  void decTimeRest() {
    if (timeRest > 1) {
      timeRest--;
    }
    if (isRest()) {
      restart();
    }
  }

  @action
  void start() {
    started = true;
    _timer = Timer.periodic(
      Duration(milliseconds: _timerValue),
      (timer) {
        if (minutes == 0 && seconds == 0) {
          _toggleIntervalType();
          return;
        }

        if (seconds == 0) {
          seconds = 59;
          minutes--;
          return;
        }

        seconds--;
      },
    );
  }

  @action
  void stop() {
    started = false;
    _timer?.cancel();
  }

  @action
  void restart() {
    stop();
    minutes = timeWork;
    seconds = 0;
    intervalType = IntervalType.WORK;
  }

  bool isWork() {
    return intervalType == IntervalType.WORK;
  }

  bool isRest() {
    return intervalType == IntervalType.REST;
  }

  void _toggleIntervalType() {
    seconds = 0;

    if (isWork()) {
      intervalType = IntervalType.REST;
      minutes = timeRest;
      return;
    }

    minutes = timeWork;
    intervalType = IntervalType.WORK;
  }

  void toggleTimerValue() {
    if (_timerValue == 1000) {
      _timerValue = 30;
    } else {
      _timerValue = 1000;
    }

    if (started) {
      stop();
      start();
    }
  }
}
