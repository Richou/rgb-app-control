import 'package:flutter/material.dart';

class RandomColorWidget extends StatefulWidget {
  @override
  createState() => new RandomColorWidgetState();
}

class RandomColorWidgetState extends State<RandomColorWidget> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Random Color')
      ),
      body: new Center(
        child: new Text('Randomize a color'),
      )
    );
  }
}