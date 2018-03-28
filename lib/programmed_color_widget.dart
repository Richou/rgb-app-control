import 'package:flutter/material.dart';

class ProgrammedColorWidget extends StatefulWidget {
  @override
  createState() => new ProgrammedColorWidgetState();
}

class ProgrammedColorWidgetState extends State<ProgrammedColorWidget> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Programmed Color')
      ),
      body: new Center(
        child: new Text('Choose a Color program'),
      )
    );
  }
}