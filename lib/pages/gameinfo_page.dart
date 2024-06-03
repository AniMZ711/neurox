import 'package:flutter/material.dart';

class GameInfoPage extends StatelessWidget {
  final String title;

  const GameInfoPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Info', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 500,
            height: 100,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 50,
          ),
          const Text("Game description goes here"),
        ],
      ),
    );
  }
}
