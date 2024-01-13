import 'dart:io';

import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final dynamic image;
  final String title;
  final String category;
  final String location;
  final String infoText;
  final String eventCreator;

  EventCard({
    required this.image,
    required this.title,
    required this.category,
    required this.location,
    required this.infoText,
    required this.eventCreator,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          image is File
              ? Image.file(
                  image,
                  height: 150, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  image,
                  height: 150, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${category}'),
                Text('Location: ${location}'),
                Text('Info: ${infoText}'),
                Text('Creator: ${eventCreator}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}