import 'package:flutter/material.dart';
import 'package:rgb_control_app/color_mapping.dart';
import 'package:rgb_control_app/favorites_color_manager.dart';

class FavoritesColorWidget extends StatefulWidget {
  @override
  createState() => new FavoritesColorWidgetState();
}

class FavoritesColorWidgetState extends State<FavoritesColorWidget> {
  FavoriteColorManager favoriteColorManager = new FavoriteColorManager();

  List<String> favoritesColors = new List<String>();

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

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new ListView.builder(
        itemCount: favoritesColors.length,
        itemBuilder: (context, index) {
          final item = favoritesColors[index];

          return new Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify Widgets.
            key: new Key(item),
            // We also need to provide a function that will tell our app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              favoriteColorManager.removeColorAt(index);

              Scaffold.of(context).showSnackBar(
                  new SnackBar(content: new Text("$item dismissed")));
            },
            // Show a red background as the item is swiped away
            background: new Container(color: Colors.red),
            child: new InkWell(
              onTap: () {
                print("$item tapped");
              },
              child: new ListTile(title: new Text('$item'),
            ),),
          );
        },
      ),
    );
  }
}
