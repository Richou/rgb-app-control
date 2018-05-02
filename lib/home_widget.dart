import 'package:flutter/material.dart';

import 'package:rgb_control_app/color_picker_widget.dart';
import 'package:rgb_control_app/random_color_widget.dart';
import 'package:rgb_control_app/favorites_color_widget.dart';
import 'package:rgb_control_app/settings_widget.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget body,
    String title,
    FloatingActionButton fab,
    TickerProvider vsync,
  }) : _body = body,
       item = new BottomNavigationBarItem(
         icon: icon,
         title: new Text(title),
       ),
       fab = fab,
       controller = new AnimationController(
         duration: kThemeAnimationDuration,
         vsync: vsync,
       ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _body;
  final BottomNavigationBarItem item;
  final FloatingActionButton fab;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Color iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    
    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            child: _body,
          ),
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  createState() => new HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {

  FloatingActionButton _fab;
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;

  SettingsWidget settingsWidget = new SettingsWidget();

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.select_all),
        title: "Picker",
        fab: new FloatingActionButton(
          onPressed: () {
            
          },
          tooltip: 'Save to Favorites',
          child: new Icon(Icons.favorite),
        ),
        body: new ColorPickerWidget(),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.shuffle),
        title: "Random",
        fab: new FloatingActionButton(
          onPressed: () {
            
          },
          tooltip: 'Save to Favorites',
          child: new Icon(Icons.favorite),
        ),
        body: new RandomColorWidget(),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: "Favorites",
        fab: null,
        body: new FavoritesColorWidget(),
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.settings),
        title: "Settings",
        fab: new FloatingActionButton(
          onPressed: () {
            
          },
          tooltip: 'Save settings',
          child: new Icon(Icons.check),
        ),
        body: settingsWidget,
        vsync: this,
      )
    ];
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _navigationViews[_currentIndex].controller.value = 1.0;
    setState(() {
      _fab = _navigationViews[_currentIndex].fab;
    });
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) {
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

    for (NavigationIconView view in _navigationViews) {
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
          .map((NavigationIconView navigationView) => navigationView.item)
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