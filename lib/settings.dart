import 'package:flutter/material.dart';
import 'package:qurantest/logger.dart';

class Settings extends StatefulWidget {
  double fontSize;
  Settings(this.fontSize, {Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Change Font Size",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Slider(
                  value: widget.fontSize,
                  label: 'Fontsize: ${widget.fontSize}',
                  thumbColor: Colors.blue.shade900,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue,
                  onChanged: (double size) {
                    setState(() {
                      widget.fontSize = size;
                    });
                  },
                  divisions: 6,
                  min: 18.0,
                  max: 30.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Your Font Size Changes here",
                      style: TextStyle(fontSize: widget.fontSize)),
                )
              ]),
            ),
            GestureDetector(
              onTap: saveSettings(widget.fontSize, context),
              child: Container(
                color: Colors.blue,
                width: 50,
                height: 30,
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveSettings(double fontSize, BuildContext context) {
    setState(() {
      Log("Pressed");
      Navigator.pop(context, fontSize);
    });
  }
}
