import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'drill_state.dart';

class DrillCubit extends Cubit<DrillState> {
  DrillCubit() : super(DrillState(count: 0, color: Colors.white));

  void increment() {
    emit(DrillState(
      count: state.count + 1,
      color: Colors.primaries[state.count % Colors.primaries.length],
    ));
  }

  void reset() {
    emit(DrillState(count: 0, color: Colors.white));
  }
}
