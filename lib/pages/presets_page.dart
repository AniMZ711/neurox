import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PresetsPage extends StatefulWidget {
  @override
  _PresetsPageState createState() => _PresetsPageState();
}

class _PresetsPageState extends State<PresetsPage> {
  List<String> presets = [];

  @override
  void initState() {
    super.initState();
    _loadPresets();
  }

  Future<void> _loadPresets() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      presets = prefs.getStringList('presets') ?? [];
    });
  }

  Future<void> _deletePreset(String presetName) async {
    final prefs = await SharedPreferences.getInstance();
    final deletedPresetString = prefs.getString('preset_$presetName');
    if (deletedPresetString != null) {
      setState(() {
        presets.remove(presetName);
        prefs.setStringList('presets', presets);
        prefs.remove('preset_$presetName');
      });

      // Show Snackbar with Undo option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$presetName gelöscht'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          action: SnackBarAction(
            label: 'Rückgängig',
            onPressed: () {
              // Undo deletion
              setState(() {
                presets.add(presetName);
                prefs.setStringList('presets', presets);
                prefs.setString('preset_$presetName', deletedPresetString);
              });
            },
          ),
        ),
      );
    }
  }

  Future<void> _loadPreset(String presetName) async {
    final prefs = await SharedPreferences.getInstance();
    final presetString = prefs.getString('preset_$presetName');
    if (presetString != null) {
      final preset = jsonDecode(presetString);
      Navigator.pop(context, preset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presets'),
      ),
      body: ListView.builder(
        itemCount: presets.length,
        itemBuilder: (context, index) {
          final presetName = presets[index];
          return ListTile(
            title: Text(presetName),
            onTap: () => _loadPreset(presetName),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deletePreset(presetName),
            ),
          );
        },
      ),
    );
  }
}
