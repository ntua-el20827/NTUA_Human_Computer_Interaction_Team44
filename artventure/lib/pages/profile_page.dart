import 'package:flutter/material.dart';
import 'package:artventure/models/user_model.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}'),
            Text('Favorite Art: ${user.favoriteArt}'),
            Text('Age: ${user.age}'),
            Text('Points: ${user.points}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}
