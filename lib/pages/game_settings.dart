import 'package:flutter/material.dart';
import 'package:neurox/pages/drill.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> colors = ['Rot', 'Blau', 'Grün', 'Gelb'];
  List<String> directions = ['↑', '↓', '←', '→', '↖', '↗', '↙', '↘'];
  Duration interval = Duration(seconds: 1);
  Duration duration = Duration(seconds: 10);
  List<String> selectedColors = [];
  List<String> selectedDirections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drill Einstellungen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Farben auswählen:'),
            Wrap(
              spacing: 8.0,
              children: colors.map((color) {
                return FilterChip(
                  label: Text(color),
                  selected: selectedColors.contains(color),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedColors.add(color);
                      } else {
                        selectedColors.remove(color);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Pfeilrichtungen auswählen:'),
            Wrap(
              spacing: 8.0,
              children: directions.map((direction) {
                return FilterChip(
                  label: Text(direction),
                  selected: selectedDirections.contains(direction),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedDirections.add(direction);
                      } else {
                        selectedDirections.remove(direction);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Intervall:'),
            Slider(
              value: interval.inMilliseconds.toDouble(),
              min: 500, // Minimum interval of 0.5 seconds
              max: 5000, // Maximum interval of 5 seconds
              divisions: 9, // Steps of 0.5 seconds
              label:
                  '${(interval.inMilliseconds / 1000).toStringAsFixed(1)} Sekunden',
              onChanged: (value) {
                setState(() {
                  interval = Duration(milliseconds: value.toInt());
                });
              },
            ),
            const Text('Dauer:'),
            Slider(
              value: duration.inSeconds.toDouble(),
              min: 10,
              max: 120,
              divisions: 22,
              label: '${duration.inSeconds} Sekunden',
              onChanged: (value) {
                setState(() {
                  duration = Duration(seconds: value.toInt());
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedColors.isEmpty && selectedDirections.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Bitte wählen Sie mindestens eine Farbe oder eine Richtung aus.'),
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrillPage(
                      colors: selectedColors,
                      directions: selectedDirections,
                      interval: interval,
                      duration: duration,
                    ),
                  ),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
