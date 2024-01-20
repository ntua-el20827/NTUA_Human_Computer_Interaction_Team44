import 'dart:io';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  final String location;
  final String infoText;
  final String eventCreator;
  final VoidCallback onDeletePressed;

  EventCard({
    required this.image,
    required this.title,
    required this.category,
    required this.location,
    required this.infoText,
    required this.eventCreator,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildImageWidget(),
          ListTile(
            title: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 18.0, top: 10),
                child: Text(
                  '$title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: $category '),
                Text('Location: $location '),
                Text(
                    '${infoText}'), // Infotext contains all the important information
                //Text('Event Creator: $eventCreator'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: onDeletePressed,
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    if (image.startsWith('assets/')) {
      return Image.asset(
        image,
        fit: BoxFit.cover,
        height: 200,
      );
    } else {
      return Image.file(
        File(image),
        fit: BoxFit.cover,
        height: 200,
      );
    }
  }
}
