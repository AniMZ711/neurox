// import 'package:flutter/material.dart';
// import 'package:neurox/components/game_card.dart';
// import 'package:neurox/pages/gameinfo_page.dart';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   void _navigateToGameInfo(BuildContext context, String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GameInfoPage(title: title),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NEUROX', style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: Column(children: <Widget>[
//           Text("Lets start training!",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           SizedBox(
//             height: 50,
//           ),
//           GestureDetector(
//             onTap: () {
//               _navigateToGameInfo(context, "Drill Generator");
//             },
//             child: GameCard(title: "Drill Generator"),
//           ),
//           GestureDetector(
//             onTap: () {
//               _navigateToGameInfo(context, "Reaction");
//             },
//             child: GameCard(title: "Reaction"),
//           ),
//         ]),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:neurox/components/game_card.dart';
import 'package:neurox/pages/game_settings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NEUROX'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
              child: GameCard(title: "Drill Generator"),
            ),
          ],
        ))
        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => SettingsPage()),
        //       );
        //     },
        //     child: Text('Drill Einstellungen'),
        //   ),
        // ),
        );
  }
}
