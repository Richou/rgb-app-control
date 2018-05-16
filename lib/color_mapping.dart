import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class ColorMapping {

    Future<ColorValues> getColorMappings(Color color) async {
      Map colorMapped = convertColorToMap(color);
      ColorBindings colorBinded = await getColorBindings();
      return new ColorValues()
        ..red = colorMapped[colorBinded.red]
        ..blue = colorMapped[colorBinded.blue]
        ..green = colorMapped[colorBinded.green];
    }

    Future<ColorBindings> getColorBindings() async {
      String colorBindingJson = await _getColorBindingsString();
      return ColorBindings.fromJson(json.decode(colorBindingJson));
    }

    _getColorBindingsString() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString("ColorBindings");
    }

    Map convertColorToMap(Color color) {
      Map colorMap = new Map();
      colorMap['red'] = color.red;
      colorMap['green'] = color.green;
      colorMap['blue'] = color.blue;
      return colorMap;
    }
}

class ColorBindings {
  String red;
  String blue;
  String green;

  ColorBindings({this.red, this.blue, this.green});

  Map toMap() {
    Map map = new Map();
    map['red'] = this.red;
    map['blue'] = this.blue;
    map['green'] = this.green;
    return map;
  }

  factory ColorBindings.fromJson(Map<String, dynamic> json) {
    return new ColorBindings(
      red: json['red'],
      green: json['green'],
      blue: json['blue']
    );
  }
}

class ColorValues {
  int red;
  int blue;
  int green;

  ColorValues({this.red, this.blue, this.green});

  Map toMap() {
    Map map = new Map();
    map['red'] = this.red;
    map['blue'] = this.blue;
    map['green'] = this.green;
    return map;
  }

  int toHexString() {
    String val = "0xFF${convertToHex(red)}${convertToHex(green)}${convertToHex(blue)}";
    return int.parse(val);
  }

  String convertToHex(int toConvert) {
    String hex = toConvert.toRadixString(16);
    if (hex.length == 1) return "0$hex";
    return hex;
  }

  factory ColorValues.fromJson(Map<String, dynamic> json) {
    return new ColorValues(
      red: json['red'],
      green: json['green'],
      blue: json['blue']
    );
  }
}