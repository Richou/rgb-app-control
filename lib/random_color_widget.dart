import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rgb_control_app/color_request.dart';

class RandomColorWidget extends StatefulWidget {
  const RandomColorWidget({ Key key}) : super(key: key);

  @override
  createState() => new RandomColorWidgetState();
}

class RandomColorWidgetState extends State<RandomColorWidget> {

  Color _randomColor;
  String _rgbString = "N/A";
  ColorRequest colorRequest;

  final snackBar = new SnackBar(
    content: new Text("Random color successfuly saved to Favorites !"),
  );

  @override
  void initState() {
    super.initState();
    _randomColor = Colors.green;
    colorRequest = new ColorRequest();
  }

  saveSelectedColorToFavorites() {
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _computeRandomColor() {
    double randomHue = new Random().nextDouble() * 360.0;
    Color theColor = new HSVColor.fromAHSV(1.0, randomHue, 1.0, 1.0).toColor();
    setState(() {
      _randomColor = theColor;
    });
    _computeColorStringWithMapping();
    _sendColorToIoT();
  }

  _sendColorToIoT() {
    colorRequest.sendColor(_randomColor);
  }

  _computeColorStringWithMapping() async {
    setState(() {
      _rgbString = "Red: ${_randomColor.red}, Green: ${_randomColor.green}, Blue: ${_randomColor.blue}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Center(
              child: new Text("Click on the Button bellow to create random color"),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new RaisedButton(
              child: const Text('RANDOM COLOR'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _computeRandomColor();
              },
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
              new Center(
                child: new Text(_rgbString),
              )
          ),
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Container(
              decoration: new BoxDecoration(
                color: _randomColor,
                border: new Border.all(
                  color: _randomColor,
                  width: 40.0,
                ),
              ),
            ),    
          )
        ],
      )
    );
  }
}