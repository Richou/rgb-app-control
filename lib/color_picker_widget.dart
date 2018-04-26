import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rgb_control_app/color_request.dart';

class ColorPickerWidget extends StatefulWidget {
  @override
  createState() => new ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color pickerColor = new Color(0xff443a49);
  Color currentColor = new Color(0xff443a49);

  ColorRequest colorRequest;

  @override
  void initState() {
    super.initState();
    colorRequest = new ColorRequest();
  }

  changeColor(Color color) {
    colorRequest.sendColor(color);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Color Picker')
      ),
      body: new Center(
        child: new ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
          colorPickerWidth: 1000.0,
          pickerAreaHeightPercent: 0.7,
        ),
      )
    );
  }
}