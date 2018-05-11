import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rgb_control_app/color_mapping.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteColorManager {
  static const FAVORITES_COLOR_KEY = "FavoritesColors";

  void saveColorToFavorites(Color color) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<String> savedColor = sharedPreferences.getStringList(FAVORITES_COLOR_KEY);
    if (savedColor == null) savedColor = new List<String>();
    var colorValues = convertToColorValues(color);
    savedColor.add(json.encode(colorValues.toMap()));
    sharedPreferences.setStringList(FAVORITES_COLOR_KEY, savedColor);
  }

  Future<List<String>> fetchColorsFromFavorites() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(FAVORITES_COLOR_KEY);
  }

  void removeColorAt(int index) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<String> savedColor = sharedPreferences.getStringList(FAVORITES_COLOR_KEY);
    savedColor.removeAt(index);
    sharedPreferences.setStringList(FAVORITES_COLOR_KEY, savedColor);
  }

  ColorValues convertToColorValues(Color color) {
    return new ColorValues()
        ..red = color.red
        ..green = color.green
        ..blue = color.blue;
  }
}