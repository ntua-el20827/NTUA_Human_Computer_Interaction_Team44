import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String category;
  final int points;
  final Function? onPressed; // Make the function nullable

  SmallCard({
    required this.title,
    required this.category,
    required this.points,
    this.onPressed, // Nullable parameter
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Color.fromARGB(255, 217, 180, 229),
      child: InkWell(
        onLongPress: () {
          // Call the provided function when the card is pressed, if it's not null
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
