import 'package:flutter/material.dart';

import 'package:rgb_control_app/home_widget.dart';

void main() => runApp(new RGBControlApp());

class RGBControlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent[400],
        accentColor: Colors.blueAccent[400]
      ),
      home: new HomeWidget(),
    );
  }
}