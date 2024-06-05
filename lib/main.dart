// import 'package:flutter/material.dart';
// import 'package:neurox/bloc/drill_generator_bloc.dart';
// import 'package:neurox/pages/home_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<DrillBloc>(create: (context) => DrillBloc()),
//         ],
//         child: MaterialApp(
//           home: HomePage(),
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             brightness: Brightness.light,
//           ),
//           darkTheme: ThemeData(
//             primaryColor: Colors.cyan,
//             primarySwatch: Colors.cyan,
//             brightness: Brightness.dark,
//           ),
//           themeMode: ThemeMode.dark, // Use system theme (dark or light)
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:neurox/bloc/drill_generator_bloc.dart';
import 'package:neurox/pages/home_page.dart';
import 'package:neurox/pages/search_page.dart';
import 'package:neurox/pages/settings_page.dart';
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
          home: MyHomePage(),
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primaryColor: Colors.cyan,
            primarySwatch: Colors.cyan,
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.dark, // Use system theme (dark or light)
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(), // Replace with your actual SearchPage
    SettingsPage(), // Replace with your actual SettingsPage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
      ),
    );
  }
}
