import 'package:flutter/material.dart';

class NavigationView {
  NavigationView({
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