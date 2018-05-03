import 'package:flutter/material.dart';

import 'package:rgb_control_app/color_picker_widget.dart';
import 'package:rgb_control_app/random_color_widget.dart';
import 'package:rgb_control_app/favorites_color_widget.dart';
import 'package:rgb_control_app/settings_widget.dart';
import 'package:rgb_control_app/navigation_view.dart';

class HomeWidget extends StatefulWidget {
  @override
  createState() => new HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {

  FloatingActionButton _fab;
  int _currentIndex = 0;
  List<NavigationView> _navigationViews;
  final settingsGlobalKey = new GlobalKey<SettingsWidgetState>();
  final pickerGlobalKey = new GlobalKey<ColorPickerWidgetState>();
  final randomGlobalKey = new GlobalKey<RandomColorWidgetState>();

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationView>[
      new NavigationView(
        icon: const Icon(Icons.select_all),
        title: "Picker",
        fab: new FloatingActionButton(
          onPressed: () {
            pickerGlobalKey.currentState.saveSelectedColorToFavorites();
          },
          tooltip: 'Save to Favorites',
          child: new Icon(Icons.favorite),
        ),
        body: new ColorPickerWidget(key: pickerGlobalKey),
        vsync: this,
      ),
      new NavigationView(
        icon: const Icon(Icons.shuffle),
        title: "Random",
        fab: new FloatingActionButton(
          onPressed: () {
            randomGlobalKey.currentState.saveSelectedColorToFavorites();
          },
          tooltip: 'Save to Favorites',
          child: new Icon(Icons.favorite),
        ),
        body: new RandomColorWidget(key: randomGlobalKey),
        vsync: this,
      ),
      new NavigationView(
        icon: const Icon(Icons.favorite),
        title: "Favorites",
        fab: null,
        body: new FavoritesColorWidget(),
        vsync: this,
      ),
      new NavigationView(
        icon: const Icon(Icons.settings),
        title: "Settings",
        fab: new FloatingActionButton(
          onPressed: () {
            settingsGlobalKey.currentState.submit();
          },
          tooltip: 'Save settings',
          child: new Icon(Icons.check),
        ),
        body: new SettingsWidget(key: settingsGlobalKey),
        vsync: this,
      )
    ];
    for (NavigationView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _navigationViews[_currentIndex].controller.value = 1.0;
    setState(() {
      _fab = _navigationViews[_currentIndex].fab;
    });
  }

  @override
  void dispose() {
    for (NavigationView view in _navigationViews) {
      view.controller.dispose();
    }
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationView view in _navigationViews) {
      transitions.add(view.transition(context));
    }

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {

    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _fab = _navigationViews[_currentIndex].fab;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RGB Control')
      ),
      body: new Center(
        child: _buildTransitionsStack()
      ),
      floatingActionButton: _fab,
      bottomNavigationBar: botNavBar,
    );
  }
}