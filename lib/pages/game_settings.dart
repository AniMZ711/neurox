import 'package:flutter/material.dart';
import 'package:neurox/pages/drill.dart';
import 'package:neurox/pages/presets_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //values for the filter chips
  List<String> colors = ['Rot', 'Blau', 'Grün', 'Gelb'];
  List<String> directions = ['↑', '↓', '←', '→', '↖', '↗', '↙', '↘'];
  //preset values for the sliders
  Duration interval = const Duration(seconds: 1);
  Duration duration = const Duration(seconds: 10);
  //chosen values for the filter chips
  List<String> selectedColors = [];
  List<String> selectedDirections = [];
  bool showWhiteScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Drill Einstellungen'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save_as_rounded), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresetsPage()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                // Placeholder for image
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Generiere individuelle Drill-Übungen"),
                const SizedBox(height: 20),

                const Text('Farben auswählen:'),
                Wrap(
                  spacing: 0.0,
                  runSpacing: 2.0,
                  children: colors.map((color) {
                    return Container(
                        width: MediaQuery.of(context).size.width / 4 - 8,
                        child: FilterChip(
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
                          selectedColor:
                              Colors.cyan, // Selected color for FilterChip
                          checkmarkColor:
                              Colors.white, // Color for the checkmark
                        ));
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text('Pfeilrichtungen auswählen:'),
                Column(
                  children: <Widget>[
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 0.0,
                      runSpacing: 2.0,
                      children: directions.map((direction) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 4 - 8,
                          child: FilterChip(
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
                            selectedColor:
                                Colors.cyan, // Selected color for FilterChip
                            checkmarkColor:
                                Colors.white, // Color for the checkmark
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Text('Intervall:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0.5s'), // Minimum value
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.cyan, // Active track color
                          inactiveTrackColor: Colors.white
                              .withOpacity(0.3), // Inactive track color
                          thumbColor: Colors.cyan, // Thumb color
                          overlayColor:
                              Colors.cyan.withAlpha(32), // Overlay color
                        ),
                        child: Slider(
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
                      ),
                    ),
                    Text('5s'), // Maximum value
                  ],
                ),
                const Text('Dauer:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('10s'), // Minimum value
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.cyan, // Active track color
                          inactiveTrackColor: Colors.white
                              .withOpacity(0.3), // Inactive track color
                          thumbColor: Colors.cyan, // Thumb color
                          overlayColor:
                              Colors.cyan.withAlpha(32), // Overlay color
                        ),
                        child: Slider(
                          value: duration.inSeconds.toDouble(),
                          min: 5,
                          max: 120,
                          divisions: 22,
                          label: '${duration.inSeconds} Sekunden',
                          onChanged: (value) {
                            setState(() {
                              duration = Duration(seconds: value.toInt());
                            });
                          },
                        ),
                      ),
                    ),
                    Text('120s'), // Maximum value
                  ],
                ),
                SizedBox(height: 20),
                ExpansionTile(
                    title: const Text('Trainer Einstellungen'),
                    children: <Widget>[
                      SwitchListTile(
                        title: const Text('Weißer Zwischenscreen'),
                        value: showWhiteScreen,
                        onChanged: (bool value) {
                          setState(() {
                            showWhiteScreen = value;
                          });
                        },
                      ),
                    ]),
                SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueGrey[600],
                  ),
                  onPressed: () {
                    if (selectedColors.isEmpty && selectedDirections.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Bitte wählen Sie mindestens eine Farbe oder eine Richtung aus.',
                            style: TextStyle(
                                color: Colors
                                    .white), // Ensure the snack bar text is white
                          ),
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
                          showWhiteScreen: showWhiteScreen,
                        ),
                      ),
                    );
                  },
                  child: const Text('Weiter'),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
