import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class RandomColorWidget extends StatefulWidget {
  @override
  createState() => new RandomColorWidgetState();
}

class RandomColorWidgetState extends State<RandomColorWidget> {

  Color _randomColor;
  String _rgbString = "N/A";

  @override
  void initState() {
    super.initState();
    _randomColor = Colors.green;
  }

  _computeRandomColor() {
    double randomHue = new Random().nextDouble() * 360.0;
    Color theColor = new HSVColor.fromAHSV(1.0, randomHue, 1.0, 1.0).toColor();
    setState(() {
      _randomColor = theColor;
    });
    _computeColorStringWithMapping();
  }

  _computeColorStringWithMapping() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String redBinding = sharedPreferences.getString("RedBinded");
    setState(() {
      _rgbString = "$redBinding: ${_randomColor.red}, Green: ${_randomColor.green}, Blue: ${_randomColor.blue}";
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Random Color')
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new Center(
              child: new Text("Click on the Button bellow to create random color"),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0
              ),
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
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 16.0
              ),
              child: new Text(_rgbString),
            )
          ],
        ),
      )
    );
  }
}