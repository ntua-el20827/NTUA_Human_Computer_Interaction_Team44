// challenges_page.dart
import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Challenges Page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add a silly action or navigate to another silly page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Silly Challenge Completed!'),
                  ),
                );
              },
              child: Text('Complete Silly Challenge'),
            ),
          ],
        ),
      ),
    );
  }
}
