import 'dart:io';

import 'package:flutter/material.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/models/events_model.dart';
import 'package:artventure/pages/eventcreation_page.dart';
import 'package:artventure/components/event_card.dart';
import 'package:artventure/database/database_helper.dart';

class WelcomePage extends StatefulWidget {
  final EventCreator? profile;

  const WelcomePage({Key? key, this.profile}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<Events> createdEvents = [];

  Future<void> fetchCreatedEvents() async {
    // Use your DatabaseHelper class to get the events created by the current event creator
    DatabaseHelper dbHelper = DatabaseHelper();
    createdEvents =
        await dbHelper.getEventsByCreator(widget.profile?.username ?? '');

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCreatedEvents().then((_) {
      setState(() {});
    });
  }

  void deleteEvent(Events event) async {
    // Use your DatabaseHelper class to delete the event from the database
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.deleteEvent(event);

    // Remove the event from the list
    setState(() {
      createdEvents.remove(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'This is the administrator’s profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Here you can add new events and delete existing ones.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String creatorUsername = widget.profile?.username ??
                    ''; // Get the username from the profile object
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventCreationPage(username: creatorUsername),
                  ),
                );
              },
              child: Text('Add'),
            ),
            SizedBox(height: 16),
            Text(
              'Events created by the currently logged-in event creator:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: createdEvents.length,
                itemBuilder: (context, index) {
                  final event = createdEvents[index];
                  return EventCard(
                    image: event.eventImageFilePath ?? 'assets/image_not_found.png',
                    title: event.title,
                    category: event.category,
                    location: event.location,
                    infoText: event.infoText,
                    eventCreator: event.eventCreator,
                    onDeletePressed: () {
                      deleteEvent(event);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}