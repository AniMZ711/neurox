import 'dart:async';
import 'package:bloc/bloc.dart';
import 'timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'drill_cubit.dart';

class TimerCubit extends Cubit<TimerState> {
  final DrillCubit drillCubit;

  StreamSubscription<int>? _tickerSubscription;
  int _tickCount = 0;

  TimerCubit(this.drillCubit) : super(TimerInitial());

  void startTimer(int tickCountLimit, Duration duration) {
    _tickCount = 0;
    emit(TimerRunning(_tickCount));
    drillCubit.increment();
    _startTicker(tickCountLimit, duration);
  }

  void _startTicker(int tickCountLimit, Duration duration) {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        Stream.periodic(duration, (x) => x).take(tickCountLimit).listen((_) {
      _tickCount++;
      emit(TimerRunning(_tickCount));
      drillCubit.increment();

      if (_tickCount >= tickCountLimit) {
        _tickerSubscription?.cancel();
        emit(TimerCompleted());
      }
    });
  }

  void pauseTimer() {
    if (state is TimerRunning) {
      _tickerSubscription?.pause();
      emit(TimerPaused(_tickCount));
    }
  }

  void resumeTimer() {
    if (state is TimerPaused) {
      _tickerSubscription?.resume();
      emit(TimerRunning(_tickCount));
    }
  }

  void resetTimer() {
    _tickerSubscription?.cancel();
    _tickCount = 0;
    drillCubit.reset();
    emit(TimerInitial());
  }
}
