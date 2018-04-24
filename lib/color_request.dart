import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorRequest {
  sendColor(Color color) async {
    String host = await _getFullHostFromSharedPrefs();
    print("$host");
    final response = await _callApi("$host/color");
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