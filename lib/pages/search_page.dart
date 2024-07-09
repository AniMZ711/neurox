import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            Text("Search Page",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            Text("Search Page"),
          ],
        ),
      ),
    );
  }
}
