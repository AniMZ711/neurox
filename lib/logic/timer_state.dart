abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final int tickCount;

  TimerRunning(this.tickCount);
}

class TimerPaused extends TimerState {
  final int tickCount;

  TimerPaused(this.tickCount);
}

class TimerCompleted extends TimerState {}
