import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title;

  GameCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final boxWidth = screenSize.width * 0.8;
    final boxHeight = screenSize.height * 0.2;

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/53/53286.png',
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(255, 52, 52, 52)),
          )
        ],
      )),
    );
  }
}
