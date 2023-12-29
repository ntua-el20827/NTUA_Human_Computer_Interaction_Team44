import 'package:flutter/material.dart';
import '../app_routes.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landing Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the explore page or challenges page
                // You can replace '/explore' and '/challenges' with the actual routes
                Navigator.pushNamed(context, '/explore');
              },
              child: Text("Explore Events and Challenges"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the register page
                Navigator.pushNamed(context, AppRoutes.register);
              },
              child: Text("Create an Event"),
            ),
          ],
        ),
      ),
    );
  }
}
