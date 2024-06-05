import 'package:flutter/material.dart';

class StandardBackground extends StatelessWidget {
  final Widget child;

  StandardBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.transparent,
          Colors.cyan,
          Colors.transparent,
        ],
      )),
      child: child,
    );
  }
}
