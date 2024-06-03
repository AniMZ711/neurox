import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurox/bloc/drill_generator_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrillBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Drill'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.read<DrillBloc>().add(StopDrill());
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<DrillBloc, DrillState>(
          listener: (context, state) {
            if (state is DrillStopped) {
              // Show a message with two buttons when the drill ends
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Drill beendet'),
                    content:
                        Text('Der Drill ist zu Ende. Was möchten Sie tun?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(
                              context); // Navigate back to the settings page
                        },
                        child: Text('Home'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                          context.read<DrillBloc>().add(StartDrill(
                                colors: colors,
                                directions: directions,
                                interval: interval,
                                duration: duration,
                              ));
                        },
                        child: Text('Drill neu starten'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<DrillBloc, DrillState>(
            builder: (context, state) {
              if (state is DrillInitial) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<DrillBloc>().add(StartDrill(
                            colors: colors,
                            directions: directions,
                            interval: interval,
                            duration: duration,
                          ));
                    },
                    child: Text('Start Drill'),
                  ),
                );
              } else if (state is DrillRunning) {
                return Container(
                  color: state.color.isEmpty
                      ? Colors.white
                      : _getColor(state.color),
                  child: Center(
                    child: state.direction.isEmpty
                        ? Container()
                        : _getDirectionIcon(state.direction),
                  ),
                );
              } else if (state is DrillStopped) {
                return Center(
                  child: Text(state
                      .message), // Display the message from DrillStopped state
                );
              } else {
                return Center(
                  child: Text('Unbekannter Zustand'),
                );
              }
            },
          ),
        ),
      ),
    );
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
        return Colors.white;
    }
  }

  Widget _getDirectionIcon(String direction) {
    IconData iconData;
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
        return Container(); // Return an empty container when no direction is provided
    }
    return Icon(
      iconData,
      size: 100.0,
      color: Colors.white,
    );
  }
}
