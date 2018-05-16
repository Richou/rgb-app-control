import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rgb_control_app/color_mapping.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var savedColorsString = sharedPreferences.getStringList(FAVORITES_COLOR_KEY);
    if (savedColorsString == null) return new List();
    return savedColorsString;
  }

  void removeColor(String item) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    List<String> savedColor = sharedPreferences.getStringList(FAVORITES_COLOR_KEY);
    savedColor.remove(item);
    sharedPreferences.setStringList(FAVORITES_COLOR_KEY, savedColor);
  }

  ColorValues convertToColorValues(Color color) {
    return new ColorValues()
        ..red = color.red
        ..green = color.green
        ..blue = color.blue;
  }
}