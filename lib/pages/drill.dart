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

  DrillPage({
    required this.colors,
    required this.directions,
    required this.interval,
    required this.duration,
  });

  bool _isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrillCubit, DrillState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: state.color,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Use arrow back icon for back button
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
              icon: Icon(Icons.refresh), // Use refresh icon for reset
              onPressed: () {
                _isButtonPressed = false;
                context.read<TimerCubit>().resetTimer();
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: BlocBuilder<TimerCubit, TimerState>(
                builder: (context, timerState) {
                  if (timerState is TimerRunning || _isButtonPressed) {
                    return Container(); // return an empty container when timer is running or button has been pressed
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        _isButtonPressed = true;
                        context
                            .read<TimerCubit>()
                            .startTimer(duration.inSeconds, interval);
                      },
                      child: Icon(Icons.play_arrow), // Use play arrow icon
                    );
                  }
                },
              ),
            ),
            BlocBuilder<TimerCubit, TimerState>(
              builder: (context, timerState) {
                return Column(
                  children: [
                    if (timerState is TimerRunning) ...[
                      Text('Tick count: ${timerState.tickCount}'),
                    ] else if (timerState is TimerPaused) ...[
                      Text('Tick count: ${timerState.tickCount}'),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Color _getColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'rot':
        return Colors.red;
      case 'blau':
        return Colors.blue;
      case 'grün':
        return Colors.green;
      case 'gelb':
        return Colors.yellow;
      default:
        try {
          return Color(
              int.parse(colorName.split('(0x')[1].split(')')[0], radix: 16));
        } catch (e) {
          return Colors.white;
        }
    }
  }

  Widget _getDirectionIcon(String direction) {
    IconData? iconData;
    switch (direction) {
      case '↑':
        iconData = Icons.arrow_upward;
        break;
      case '↓':
        iconData = Icons.arrow_downward;
        break;
      case '←':
        iconData = Icons.arrow_back;
        break;
      case '→':
        iconData = Icons.arrow_forward;
        break;
      case '↖':
        iconData = Icons.north_west;
        break;
      case '↗':
        iconData = Icons.north_east;
        break;
      case '↙':
        iconData = Icons.south_west;
        break;
      case '↘':
        iconData = Icons.south_east;
        break;
      default:
        try {
          iconData = IconData(
              int.parse(direction.split('(0x')[1].split(')')[0], radix: 16),
              fontFamily: 'MaterialIcons');
          return Icon(
            iconData,
            size: 100.0,
            color: Colors.white,
          );
        } catch (e) {
          return Container();
        }
    }
    return Icon(
      iconData,
      size: 100.0,
      color: Colors.white,
    );
  }
}
