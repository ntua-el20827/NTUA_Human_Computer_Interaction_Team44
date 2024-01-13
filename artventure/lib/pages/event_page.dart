import 'dart:io';
import 'package:flutter/material.dart';
import 'package:artventure/models/events_model.dart';

class EventPage extends StatelessWidget {
  final Events event;

  EventPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: (event.eventImageFilePath != null &&
                        event.eventImageFilePath!.isNotEmpty)
                    ? Image.file(File(event.eventImageFilePath!),
                        fit: BoxFit.cover)
                    : Image.asset('assets/image_not_found.png',
                        fit: BoxFit.cover),
              ),
              SizedBox(height: 16),
              Text(
                event.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                event.infoText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Location: ${event.location}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
