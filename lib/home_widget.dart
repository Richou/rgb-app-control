import 'package:flutter/material.dart';

import 'package:rgb_control_app/color_picker_widget.dart';
import 'package:rgb_control_app/random_color_widget.dart';
import 'package:rgb_control_app/favorites_color_widget.dart';
import 'package:rgb_control_app/settings_widget.dart';

class HomeWidget extends StatefulWidget {
  @override
  createState() => new HomeWidgetState();
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
      child: new Image.asset('images/color-picker.png'),
    );
  }
}

class HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: new CustomIcon(),
        title: new Text("Picker"),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.shuffle),
        title: new Text("Random"),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.favorite),
        title: new Text("Favorites"),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.settings),
        title: new Text("Settings"),
      )
    ];
  }

  void _onOpenWidgetClicked(Widget widget) {
    Navigator.of(context).push(new MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return widget;
      }
    ));
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

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((BottomNavigationBarItem navigationView) => navigationView)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RGB Control')
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            _buildMenuItem('images/color-picker.png', 'Color Picker', new ColorPickerWidget()),
            _buildMenuItem('images/random.png', 'Random Color', new RandomColorWidget()),
            _buildMenuItem('images/star.png', 'Demo', new FavoritesColorWidget()),
            _buildMenuItem('images/settings.png', 'Settings', new SettingsWidget()),
          ],
        ),
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}