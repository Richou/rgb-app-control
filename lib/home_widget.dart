import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  createState() => new HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {

  void _onColorPickerSelected() {

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RGB Control')
      ),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new InkWell(
              onTap: () { _onColorPickerSelected(); },
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Image.asset('images/color-picker.png'),
                  ),
                  new Expanded(
                    child: new RichText(
                      text: new TextSpan(text: 'Color Picker', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20.0)),
                    ),
                  )
                ],
              )
            ),
            new Row(children: <Widget>[
              new Expanded(
                child: new Image.asset('images/random.png'),
              ),
              new Expanded(
                child: new RichText(
                  text: new TextSpan(text: 'Random Color', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20.0)),
                )
              )
            ],)
          ],
        ),
      )
    );
  }
}