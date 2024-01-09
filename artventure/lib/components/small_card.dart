import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String category;
  final int points;

  SmallCard({
    required this.title,
    required this.category,
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
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: $category'),
                Text('Points: $points'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
