import 'package:flutter/material.dart';

import 'package:rgb_control_app/home_widget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new HomeWidget(),
    );
  }
}