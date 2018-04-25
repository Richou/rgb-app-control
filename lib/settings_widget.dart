import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rgb_control_app/color_mapping.dart';
import 'dart:convert';

class SettingsWidget extends StatefulWidget {
  @override
  createState() => new SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {

  final formKey = new GlobalKey<FormState>();
  final _ipAddressController = new TextEditingController();
  final _portController = new TextEditingController();

  List<String> _rgbValues = new List<String>();

  String _ipAddress;
  int _port;
  String _redBinding;
  String _greenBinding;
  String _blueBinding;

  @override
  void initState() {
    super.initState();
    _rgbValues.addAll(["red", "green", "blue"]);
    _setSavedIpAddress();
    _setSavedPort();
    _setSavedColorsBinding();
  }

  void _onRedChanged(String value) {
    value = (value != null) ? value : "red";
    setState(() {
      _redBinding = value;
    });
  }

  void _onGreenChanged(String value) {
    value = (value != null) ? value : "red";
    setState(() {
      _greenBinding = value;
    });
  }

  void _onBlueChanged(String value) {
    value = (value != null) ? value : "red";
    setState(() {
      _blueBinding = value;
    });
  }

  _setSavedIpAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _ipAddressController.text = sharedPreferences.getString("IPAddress");
  }

  _setSavedPort() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _portController.text = sharedPreferences.getInt("Port").toString();
  }

  _setSavedColorsBinding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsoned = sharedPreferences.getString("ColorBindings");
    ColorBindings colorBindings = ColorBindings.fromJson(json.decode(jsoned));
    _onRedChanged(colorBindings.red);
    _onGreenChanged(colorBindings.green);
    _onBlueChanged(colorBindings.blue);
  }

  _onSavePressed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("IPAddress", _ipAddress);
    sharedPreferences.setInt("Port", _port);
    ColorBindings colorBindings = new ColorBindings()
      ..red = _redBinding
      ..blue = _blueBinding
      ..green = _greenBinding;

    sharedPreferences.setString("ColorBindings", json.encode(colorBindings.toMap()));
    Navigator.pop(context);
  }

  _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      
      _onSavePressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () { _submit(); })
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0
            ),
            child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: new Text("Network", style: new TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'IP Address'),
                    keyboardType: TextInputType.number,
                    controller: _ipAddressController,
                    onSaved: (val) => _ipAddress = _ipAddressController.text,
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Port'),
                    keyboardType: TextInputType.number,
                    controller: _portController,
                    onSaved: (val) => _port = int.parse(_portController.text),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0
                    ),
                    child: new Text("Color Bindings", style: new TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text("Red :"),
                        flex: 1,
                      ),
                      new Expanded(
                        child: new DropdownButton(
                          value: _redBinding,
                          onChanged: (newValue) {_onRedChanged(newValue);},
                          items: _rgbValues.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text("Green :"),
                        flex: 1,
                      ),
                      new Expanded(
                        child: new DropdownButton(
                          value: _greenBinding,
                          onChanged: (newValue) {_onGreenChanged(newValue);},
                          items: _rgbValues.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Text("Blue :"),
                        flex: 1,
                      ),
                      new Expanded(
                        child: new DropdownButton(
                          value: _blueBinding,
                          onChanged: (newValue) {_onBlueChanged(newValue);},
                          items: _rgbValues.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                        flex: 3,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}