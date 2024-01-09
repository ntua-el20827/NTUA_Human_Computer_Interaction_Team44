import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String info;
  final int points;

  BigCard({
    required this.image,
    required this.title,
    required this.category,
    required this.info,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(image), // Replace with your image source
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: $category'),
                Text('Info: $info'),
                Text('Points: $points'),
              ],
            ),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // Action 1
                },
                child: Text('ACTION 1'),
              ),
              TextButton(
                onPressed: () {
                  // Action 2
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
