import 'package:flutter/material.dart';

class ColorPickerWidget extends StatefulWidget {
  @override
  createState() => new ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Color Picker')
      ),
      body: new Center(
        child: new Text('Pick a color'),
      )
    );
  }
}