import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'dart:math';

// Events
abstract class DrillEvent extends Equatable {
  const DrillEvent();

  @override
  List<Object> get props => [];
}

class StartDrill extends DrillEvent {
  final List<String> colors;
  final List<String> directions;
  final Duration interval;
  final Duration duration;

  const StartDrill({
    required this.colors,
    required this.directions,
    required this.interval,
    required this.duration,
  });

  @override
  List<Object> get props => [colors, directions, interval, duration];
}

class StopDrill extends DrillEvent {}

class UpdateDrill extends DrillEvent {
  final String color;
  final String direction;

  const UpdateDrill({required this.color, required this.direction});

  @override
  List<Object> get props => [color, direction];
}

// States
abstract class DrillState extends Equatable {
  const DrillState();

  @override
  List<Object> get props => [];
}

class DrillInitial extends DrillState {}

class DrillRunning extends DrillState {
  final String color;
  final String direction;

  const DrillRunning({required this.color, required this.direction});

  @override
  List<Object> get props => [color, direction];
}

class DrillStopped extends DrillState {
  final String message;

  const DrillStopped({this.message = 'Ende'});

  @override
  List<Object> get props => [message];
}

// Bloc
class DrillBloc extends Bloc<DrillEvent, DrillState> {
  Timer? _timer;
  Timer? _durationTimer;
  final Random _random = Random();

  DrillBloc() : super(DrillInitial()) {
    on<StartDrill>(_onStartDrill);
    on<StopDrill>(_onStopDrill);
    on<UpdateDrill>(_onUpdateDrill);
  }

  Future<void> _onStartDrill(StartDrill event, Emitter<DrillState> emit) async {
    print('StartDrill event received');
    _timer?.cancel();
    _durationTimer?.cancel();

    // Emit initial state immediately
    final initialColor = event.colors[_random.nextInt(event.colors.length)];
    final initialDirection =
        event.directions[_random.nextInt(event.directions.length)];
    emit(DrillRunning(color: initialColor, direction: initialDirection));

    // Schedule the periodic updates
    _timer = Timer.periodic(event.interval, (timer) {
      final color = event.colors[_random.nextInt(event.colors.length)];
      final direction =
          event.directions[_random.nextInt(event.directions.length)];
      print(
          'Dispatching UpdateDrill event with color: $color and direction: $direction');
      add(UpdateDrill(color: color, direction: direction));
    });

    // Schedule the end of the drill
    _durationTimer = Timer(event.duration, () {
      print('Drill duration ended, stopping drill');
      add(StopDrill());
    });
  }

  Future<void> _onStopDrill(StopDrill event, Emitter<DrillState> emit) async {
    print('StopDrill event received');
    _timer?.cancel();
    _durationTimer?.cancel();
    emit(DrillStopped());
  }

  Future<void> _onUpdateDrill(
      UpdateDrill event, Emitter<DrillState> emit) async {
    emit(DrillRunning(color: event.color, direction: event.direction));
  }
}
