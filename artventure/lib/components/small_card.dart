import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String category;
  final int points;
  final Function? onPressed; // A small card may or may not have a function

  SmallCard({
    required this.title,
    required this.category,
    required this.points,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Color.fromARGB(255, 217, 180, 229),
      child: InkWell(
        onTap: () {
          // Show message that says: Hold a challenge to learn more!
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hold a challenge to learn more !'),
            ),
          );
        },
        onLongPress: () {
          onPressed?.call();
        },
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
      ),
    );
  }
}
