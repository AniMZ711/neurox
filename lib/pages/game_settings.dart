import 'package:flutter/material.dart';
import 'package:neurox/pages/drill.dart';
import 'package:neurox/pages/presets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  final Map<String, dynamic>? preset;

  SettingsPage({this.preset});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> colors = ['Rot', 'Blau', 'Grün', 'Gelb'];
  List<String> directions = ['↑', '↓', '←', '→', '↖', '↗', '↙', '↘'];
  Duration interval = const Duration(seconds: 1);
  Duration duration = const Duration(seconds: 10);
  List<String> selectedColors = [];
  List<String> selectedDirections = [];
  bool showWhiteScreen = false;

  @override
  void initState() {
    super.initState();
    if (widget.preset != null) {
      selectedColors = List<String>.from(widget.preset!['selectedColors']);
      selectedDirections =
          List<String>.from(widget.preset!['selectedDirections']);
      interval = Duration(milliseconds: widget.preset!['interval']);
      duration = Duration(seconds: widget.preset!['duration']);
      showWhiteScreen = widget.preset!['showWhiteScreen'];
    }
  }

  Future<void> _savePreset(String presetName) async {
    final prefs = await SharedPreferences.getInstance();
    final preset = {
      'selectedColors': selectedColors,
      'selectedDirections': selectedDirections,
      'interval': interval.inMilliseconds,
      'duration': duration.inSeconds,
      'showWhiteScreen': showWhiteScreen,
    };
    final presets = prefs.getStringList('presets') ?? [];
    if (!presets.contains(presetName)) {
      presets.add(presetName);
      await prefs.setStringList('presets', presets);
    }
    await prefs.setString('preset_$presetName', jsonEncode(preset));
  }

  Future<void> _showSavePresetDialog() async {
    final TextEditingController controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bennene deine Übung'),
          content: TextField(
            controller: controller,
            cursorColor: Colors.cyan,
            decoration: const InputDecoration(
              hintText: "Name der Übung",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the value as needed
                ),
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  _savePreset(controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Übung in Presets gespeichert',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );

                  Navigator.of(context).pop();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Achtung'),
                        content: const Text(
                            'Du musst deiner Übung einen Namen geben.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK',
                                style: TextStyle(color: Colors.cyan)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Speichern',
                  style: TextStyle(color: Colors.blueGrey)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Drill Einstellungen'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save_as_rounded),
              onPressed: () {
                _showSavePresetDialog();
              },
            ),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PresetsPage()),
                );
                if (result != null) {
                  setState(() {
                    selectedColors =
                        List<String>.from(result['selectedColors']);
                    selectedDirections =
                        List<String>.from(result['selectedDirections']);
                    interval = Duration(milliseconds: result['interval']);
                    duration = Duration(seconds: result['duration']);
                    showWhiteScreen = result['showWhiteScreen'];
                  });
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
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
                    return SizedBox(
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
                          selectedColor: Colors.cyan,
                          checkmarkColor: Colors.white,
                        ));
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Text('Pfeilrichtungen auswählen:'),
                Column(
                  children: <Widget>[
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 0.0,
                      runSpacing: 2.0,
                      children: directions.map((direction) {
                        return SizedBox(
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
                            selectedColor: Colors.cyan,
                            checkmarkColor: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Intervall:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('0.5s'),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.cyan,
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                          thumbColor: Colors.white,
                          overlayColor: Colors.cyan.withAlpha(32),
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          valueIndicatorColor: Colors.blueGrey,
                        ),
                        child: Slider(
                          value: interval.inMilliseconds.toDouble(),
                          min: 500,
                          max: 5000,
                          divisions: 9,
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
                    const Text('5s'),
                  ],
                ),
                const Text('Dauer:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('10s'),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.cyan,
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                          thumbColor: Colors.white,
                          overlayColor: Colors.cyan.withAlpha(32),
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
                    Text('120s'),
                  ],
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                    title: const Text('Trainer Einstellungen'),
                    collapsedIconColor: Colors.cyan,
                    iconColor: Colors.white,
                    children: <Widget>[
                      SwitchListTile(
                        title: const Text('Weißer Zwischenscreen'),
                        value: showWhiteScreen,
                        activeTrackColor: Colors.cyan,
                        activeColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            showWhiteScreen = value;
                          });
                        },
                      ),
                    ]),
                const SizedBox(height: 20),
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
                            style: TextStyle(color: Colors.white),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
