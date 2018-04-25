import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ColorMapping {
    /*String jsoned = json.encode(colorBindings.toMap());
    ColorBindings revert = ColorBindings.fromJson(json.decode(jsoned));
    print(revert.red);*/
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
}