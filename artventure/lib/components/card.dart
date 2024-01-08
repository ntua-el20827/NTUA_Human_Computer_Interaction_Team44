import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text('Card Title'),
            subtitle: Text('Subtitle or additional information'),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // Perform an action when the button is pressed
                },
                child: Text('ACTION 1'),
              ),
              TextButton(
                onPressed: () {
                  // Perform another action when the button is pressed
                },
                child: Text('ACTION 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
