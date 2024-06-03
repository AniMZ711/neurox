import 'package:flutter/material.dart';
import 'package:neurox/bloc/drill_generator_bloc.dart';
import 'package:neurox/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DrillBloc>(create: (context) => DrillBloc()),
        ],
        child: MaterialApp(
          home: HomePage(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primaryColor: Colors.cyan,
            primarySwatch: Colors.cyan,
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.light, // Use system theme (dark or light)
        ));
  }
}
