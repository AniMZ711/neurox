import 'package:flutter/material.dart';

class DrillState {
  final int count;
  final Color color;
  final String direction;
  final IconData? icon;

  DrillState({
    required this.count,
    required this.color,
    required this.direction,
    this.icon,
  });
}
