import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorRequest {
  sendColor(Color color) async {
    String ipAddress = await _getSavedIpAddressFromSharedPrefs();
    print("http://$ipAddress");
    _callApi("http://$ipAddress:80");
  }

  _callApi(String host) async {
    return await http.get(host);
  }

  _getSavedIpAddressFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("IPAddress");
  }
}