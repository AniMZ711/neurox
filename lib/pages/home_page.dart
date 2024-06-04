import 'package:flutter/material.dart';
import 'package:neurox/components/game_card.dart';
import 'package:neurox/components/navbar.dart';
import 'package:neurox/pages/game_settings.dart';
import 'package:neurox/pages/gameinfo_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToGameSettings(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }

  int currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    HomePage(),
    HomePage(),
    SettingsPage(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEUROX', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text("Lets start training!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              _navigateToGameSettings(context, "Drill Generator");
            },
            child: GameCard(title: "Drill Generator"),
          ),
          GestureDetector(
            onTap: () {
              _navigateToGameSettings(context, "Reaction");
            },
            child: GameCard(title: "Reaction"),
          ),
        ]),
      ),
      // bottomNavigationBar: NavigationBar(
      //   labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      //   onDestinationSelected: _onDestinationSelected,
      //   indicatorColor: Colors.cyan,
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.search),
      //       icon: Icon(Icons.search_outlined),
      //       label: 'Suche',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.settings),
      //       icon: Icon(Icons.settings_outlined),
      //       label: 'Einstellungen',
      //     ),
      //   ],
      // ),
    );
  }
}
