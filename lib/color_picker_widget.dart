import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rgb_control_app/color_request.dart';
import 'dart:async';

class ColorPickerWidget extends StatefulWidget {
  @override
  createState() => new ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color pickerColor = new Color(0xff443a49);
  Color currentColor = new Color(0xff443a49);

  ColorRequest colorRequest;

  Timer timer;

  @override
  void initState() {
    super.initState();
    colorRequest = new ColorRequest();
  }

  onColorChanged(Color color) {
    if (this.timer != null && this.timer.isActive) this.timer.cancel();
    this.timer = new Timer(const Duration(milliseconds: 200), () {
      this.sendColorToServer(color);
    });
  }

  sendColorToServer(Color color) {
    colorRequest.sendColor(color);
    setState(() {
      currentColor = color;
    });
  }

  _saveColorToFavorite() {

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Color Picker')
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child:new Center(
                child: new Text("Pick a color to change it"),
              ),
          ),
          new Expanded(
            flex: 10,
            child: new Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 15.0
              ),
              child: new ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: onColorChanged,
                colorPickerWidth: 800.0,
                pickerAreaHeightPercent: 0.6,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new RaisedButton(
              child: const Text('SAVE COLOR TO FAVORITE'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _saveColorToFavorite();
              },
            ),
          ),
        ],
      )
    );
  }
}