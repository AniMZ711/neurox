import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurox/logic/drill_cubit.dart';
import 'package:neurox/logic/drill_state.dart';
import 'package:neurox/logic/timer_cubit.dart';
import 'package:neurox/logic/timer_state.dart';

class DrillPage extends StatelessWidget {
  final List<String> colors;
  final List<String> directions;
  final Duration interval;
  final Duration duration;
  final bool showWhiteScreen;

  DrillPage({
    required this.colors,
    required this.directions,
    required this.interval,
    required this.duration,
    this.showWhiteScreen = false,
  });

  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrillCubit, DrillState>(builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DrillCubit(
                selectedColors: colors,
                selectedDirections: directions,
                showWhiteScreen: showWhiteScreen),
          ),
          BlocProvider(
            create: (context) => TimerCubit(
              context.read<DrillCubit>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _isButtonPressed = false;
                context.read<TimerCubit>().resetTimer();
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
            actions: <Widget>[
              BlocBuilder<TimerCubit, TimerState>(
                builder: (context, timerState) {
                  IconData icon;
                  if (timerState is TimerRunning) {
                    icon = Icons.pause;
                  } else if (timerState is TimerPaused) {
                    icon = Icons.play_arrow;
                  } else {
                    icon = Icons.timer;
                  }

                  return IconButton(
                    icon: Icon(icon),
                    onPressed: () {
                      if (timerState is TimerInitial ||
                          timerState is TimerCompleted) {
                        context
                            .read<TimerCubit>()
                            .startTimer(duration.inSeconds, interval);
                      } else if (timerState is TimerRunning) {
                        context.read<TimerCubit>().pauseTimer();
                      } else if (timerState is TimerPaused) {
                        context.read<TimerCubit>().resumeTimer();
                      }
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  _isButtonPressed = false;
                  context.read<TimerCubit>().resetTimer();
                },
              ),
            ],
          ),
          body: BlocBuilder<DrillCubit, DrillState>(
            builder: (context, state) {
              return Container(
                  color: state.color,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: BlocBuilder<TimerCubit, TimerState>(
                            builder: (context, timerState) {
                              if (timerState is TimerRunning ||
                                  _isButtonPressed) {
                                return Container(
                                  child: Icon(
                                      _getDirectionIcon(state.direction),
                                      size: 200),
                                );
                              } else {
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          "Starte den Drill, sobald du bereit bist!",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white)),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          shape: StadiumBorder(),
                                        ),
                                        onPressed: () {
                                          _isButtonPressed = true;
                                          context.read<TimerCubit>().startTimer(
                                              duration.inSeconds, interval);
                                        },
                                        child: const Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                      )
                                    ]);
                              }
                            },
                          ),
                        ),
                      ]));
            },
          ),
        ),
      );
    });
  }
}

IconData? _getDirectionIcon(String direction) {
  switch (direction) {
    case '↑':
      return Icons.arrow_upward;
    case '↓':
      return Icons.arrow_downward;
    case '←':
      return Icons.arrow_back;
    case '→':
      return Icons.arrow_forward;
    case '↖':
      return Icons.north_west;
    case '↗':
      return Icons.north_east;
    case '↙':
      return Icons.south_west;
    case '↘':
      return Icons.south_east;
    default:
      return null;
  }
}
