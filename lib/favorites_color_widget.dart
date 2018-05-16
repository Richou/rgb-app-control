import 'package:flutter/material.dart';
import 'package:rgb_control_app/color_mapping.dart';
import 'package:rgb_control_app/favorites_color_manager.dart';
import 'package:rgb_control_app/color_request.dart';
import 'dart:convert';

class FavoritesColorWidget extends StatefulWidget {
  @override
  createState() => new FavoritesColorWidgetState();
}

class FavoritesColorWidgetState extends State<FavoritesColorWidget> {
  FavoriteColorManager favoriteColorManager = new FavoriteColorManager();

  List<String> favoritesColors = new List<String>();

  ColorRequest colorRequest = new ColorRequest();

  @override
  void initState() {
    super.initState();
    this._fetchFavoriteColors();
  }

  void _fetchFavoriteColors() async {
    List<String> colors = await favoriteColorManager.fetchColorsFromFavorites();
    setState(() {
      favoritesColors = colors;
    });
  }

  Color _renderColor(item) {
    ColorValues color = ColorValues.fromJson(json.decode(item));
    return new Color(color.toHexString());
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new ListView.builder(
        itemCount: favoritesColors.length,
        itemBuilder: (context, index) {
          final item = favoritesColors[index];

          final colorForItem = _renderColor(item);

          return new Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify Widgets.
            key: new Key(item),
            // We also need to provide a function that will tell our app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              favoriteColorManager.removeColor(item);
            },
            // Show a red background as the item is swiped away
            background: new Container(color: Colors.red),
            child: new InkWell(
              onTap: () => colorRequest.sendColor(colorForItem),
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          border: new Border.all(
                            color: colorForItem,
                            width: 20.0,
                          ),
                        ),
                      ),
                  ),
                  new Text("Red: ${colorForItem.red}, Green: ${colorForItem.green}, Blue: ${colorForItem.blue}")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
