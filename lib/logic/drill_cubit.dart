import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'drill_state.dart';
import 'dart:math';

class DrillCubit extends Cubit<DrillState> {
  final List<String>? selectedColors;
  final List<String>? selectedDirections;
  late List<Color> colors;

  final _random = Random();

  DrillCubit({this.selectedColors, this.selectedDirections})
      : super(DrillState(count: 0, color: Colors.white, direction: '')) {
    colors = selectedColors?.map(_getColor).toList() ?? [];
  }
  void increment() {
    emit(DrillState(
      count: state.count + 1,
      direction:
          selectedDirections![_random.nextInt(selectedDirections!.length)],
      color: colors[_random.nextInt(colors.length)],
    ));
  }

  void reset() {
    emit(DrillState(count: 0, color: Colors.white, direction: ''));
  }
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


// Widget _getDirectionIcon(String direction) {
//   IconData? iconData;
//   switch (direction) {
//     case '↑':
//       iconData = Icons.arrow_upward;
//       break;
//     case '↓':
//       iconData = Icons.arrow_downward;
//       break;
//     case '←':
//       iconData = Icons.arrow_back;
//       break;
//     case '→':
//       iconData = Icons.arrow_forward;
//       break;
//     case '↖':
//       iconData = Icons.north_west;
//       break;
//     case '↗':
//       iconData = Icons.north_east;
//       break;
//     case '↙':
//       iconData = Icons.south_west;
//       break;
//     case '↘':
//       iconData = Icons.south_east;
//       break;
//     default:
//       try {
//         iconData = IconData(
//             int.parse(direction.split('(0x')[1].split(')')[0], radix: 16),
//             fontFamily: 'MaterialIcons');
//         return Icon(
//           iconData,
//           size: 100.0,
//           color: Colors.white,
//         );
//       } catch (e) {
//         return Container();
//       }
//   }
//   return Icon(
//     iconData,
//     size: 100.0,
//     color: Colors.white,
//   );
// }
