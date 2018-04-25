import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rgb_control_app/color_mapping.dart';

class ColorRequest {
  sendColor(Color color) async {
    String host = await _getFullHostFromSharedPrefs();
    print("$host");
    ColorMapping colorMapping = new ColorMapping();
    ColorValues colorValues = await colorMapping.getColorMappings(color);
    final response = await _callApi("$host/color?red=${colorValues.red}&green=${colorValues.green}&blue=${colorValues.blue}");
    print(response);
  }

  _callApi(String host) async {
    return await http.get(host);
  }

  _getFullHostFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ipAdress = sharedPreferences.getString("IPAddress");
    int port = sharedPreferences.getInt("Port");
    if (port == 80) {
      return "http://$ipAdress";
    }
    return "http://$ipAdress:$port";
  }
}