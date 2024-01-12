import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String info;
  final int points;
  final String firstButtonLabel;
  final VoidCallback firstButtonAction;
  final String? secondButtonLabel;
  final VoidCallback? secondButtonAction;

  BigCard({
    required this.image,
    required this.title,
    required this.category,
    required this.info,
    required this.points,
    required this.firstButtonLabel,
    required this.firstButtonAction,
    this.secondButtonLabel,
    this.secondButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(image,
              fit: BoxFit.cover, height: 200), // Adjust height as needed
          ListTile(
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
                onPressed: firstButtonAction,
                child: Text(firstButtonLabel),
              ),
              if (secondButtonLabel != null && secondButtonAction != null)
                TextButton(
                  onPressed: secondButtonAction,
                  child: Text(secondButtonLabel!),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
