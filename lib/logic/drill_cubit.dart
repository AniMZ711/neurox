import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'drill_state.dart';
import 'dart:math';

class DrillCubit extends Cubit<DrillState> {
  final List<String>? selectedColors;
  final List<String>? selectedDirections;
  late List<Color> colors;
  final bool showWhiteScreen;

  final _random = Random();
  bool _showWhite = false;

  DrillCubit(
      {this.selectedColors,
      this.selectedDirections,
      this.showWhiteScreen = false})
      : super(DrillState(
            count: 0, color: Colors.black, direction: '', icon: null)) {
    colors = selectedColors?.map(_getColor).toList() ?? [];
  }

  void increment() {
    if (showWhiteScreen && !_showWhite) {
      emit(DrillState(
          count: state.count + 1,
          color: Colors.white,
          direction: '',
          icon: null));
      _showWhite = true;
    } else {
      String direction = '';
      IconData? icon;

      if (selectedDirections != null && selectedDirections!.isNotEmpty) {
        direction =
            selectedDirections![_random.nextInt(selectedDirections!.length)];
        icon = _getDirectionIcon(direction);
      }

      Color color = colors.isNotEmpty
          ? colors[_random.nextInt(colors.length)]
          : Colors.black;

      emit(DrillState(
          count: state.count + 1,
          direction: direction,
          color: color,
          icon: icon));
      _showWhite = false;
    }
  }

  void reset() {
    emit(DrillState(count: 0, color: Colors.white, direction: '', icon: null));
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
}
