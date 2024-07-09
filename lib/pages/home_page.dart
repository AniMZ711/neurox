import 'package:flutter/material.dart';
import 'package:neurox/components/background.dart';
import 'package:neurox/components/game_card.dart';
import 'package:neurox/pages/game_settings.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('NEUROX',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Icon(Icons.psychology_sharp)
          ])),
      body: Stack(
        children: [
          StandardBackground(child: Container()),
          SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 80),
                  const Text(
                    "Let's start training!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateToGameSettings(context, "Drill Generator");
                    },
                    child: GameCard(title: "Drill Generator"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GameCard(title: "another game "),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
