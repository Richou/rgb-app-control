import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rgb_control_app/color_request.dart';
import 'dart:async';

import 'package:rgb_control_app/favorites_color_manager.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({Key key}) : super(key: key);

  @override
  createState() => new ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
  Color pickerColor = new Color(0xff443a49);
  Color currentColor = new Color(0xff443a49);

  ColorRequest colorRequest;

  Timer timer;

  FavoriteColorManager favoritesColorManager = new FavoriteColorManager();

  final SnackBar snackBar = new SnackBar(
    content: new Text("Picked color successfuly saved to Favorites !")
  );

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

  saveSelectedColorToFavorites() {
    favoritesColorManager.saveColorToFavorites(currentColor);
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0
              ),
              child:new Center(
                child: new Text("Pick a color to change it"),
              ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 10.0,
              bottom: 50.0
            ),
            child: new ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: onColorChanged,
              colorPickerWidth: 500.0,
              pickerAreaHeightPercent: 0.4
            ),
          ),
        ],
      )
    );
  }
}