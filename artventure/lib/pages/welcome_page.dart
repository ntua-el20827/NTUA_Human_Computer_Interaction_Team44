import 'package:flutter/material.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/models/events_model.dart';
import 'package:artventure/pages/eventcreation_page.dart';
import 'package:artventure/components/event_card.dart';
import 'package:artventure/components/appbar.dart';
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
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This is the administrator’s profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Here you can add new events and delete existing ones.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: createdEvents.length,
                itemBuilder: (context, index) {
                  final event = createdEvents[index];
                  return EventCard(
                    image: event.eventImageFilePath ??
                        'assets/image_not_found.png',
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
      floatingActionButton: Positioned(
        left: 16,
        bottom: 16,
        child: FloatingActionButton(
          onPressed: () {
            String creatorUsername = widget.profile?.username ?? '';
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EventCreationPage(username: creatorUsername),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
