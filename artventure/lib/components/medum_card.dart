import 'package:flutter/material.dart';

class MediumCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final int points;

  MediumCard({
    required this.image,
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
          Image.asset(
            image, // Assuming image is the asset path
            height: 150, // Adjust the height as needed
            width: double.infinity,
            fit: BoxFit.cover,
          ),
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
