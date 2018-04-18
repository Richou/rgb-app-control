import 'package:flutter/material.dart';

class FavoritesColorWidget extends StatefulWidget {
  @override
  createState() => new FavoritesColorWidgetState();
}

class FavoritesColorWidgetState extends State<FavoritesColorWidget> {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Favorites Color')
      ),
      body: new Center(
        child: new Text('Here is the list of your favorites color !'),
      )
    );
  }
}