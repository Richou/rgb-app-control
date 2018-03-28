import 'package:flutter/material.dart';

import 'package:rgb_control_app/color_picker_widget.dart';
import 'package:rgb_control_app/random_color_widget.dart';
import 'package:rgb_control_app/programmed_color_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  createState() => new HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {

  void _onOpenWidgetClicked(Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => widget),
    );
  }

  Widget _buildMenuItem(String img, String label, Widget widget) {
    return new InkWell(
      onTap: () { _onOpenWidgetClicked(widget); },
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Image.asset(img),
            flex: 1
          ),
          new Expanded(
            child: new RichText(
              text: new TextSpan(text: label, style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20.0)),
            ),
            flex: 2,
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RGB Control')
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            _buildMenuItem('images/color-picker.png', 'Color Picker', new ColorPickerWidget()),
            _buildMenuItem('images/random.png', 'Random Color', new RandomColorWidget()),
            _buildMenuItem('images/programmed.png', 'Programmed Color', new ProgrammedColorWidget()),
          ],
        ),
      )
    );
  }
}