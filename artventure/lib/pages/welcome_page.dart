import 'package:artventure/pages/eventcreation_page.dart';
import 'package:flutter/material.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/pages/signup_eventcreators_page.dart';

class WelcomePage extends StatefulWidget {
  final EventCreator? profile;

  const WelcomePage({super.key, this.profile});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                          EventCreationPage(username: creatorUsername)),
                );
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
