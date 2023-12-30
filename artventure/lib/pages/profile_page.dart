import 'package:flutter/material.dart';
import '../components/challenge.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample user data (replace with data from your database)
  String userName = "John Doe";
  String favoriteArt = "Abstract Painting";
  String personalityInfo = "Creative and adventurous";
  int userPoints = 100; // Replace with actual user points from the database

  // Sample challenges data (replace with data from your database)
  List<Challenge> challenges = [
    Challenge("Visit an Art Gallery", 20),
    Challenge("Create a Digital Artwork", 30),
    Challenge("Write an Art Review", 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ArtVenture"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Info Segment
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display user info
                Text("Name: $userName"),
                Text("Favorite Art: $favoriteArt"),
                Text("Personality: $personalityInfo"),
                Text("Points: $userPoints"),
                // Display user avatar (replace with your avatar logic)
                CircleAvatar(
                  backgroundImage: NetworkImage("URL_TO_USER_AVATAR"),
                  radius: 50,
                ),
              ],
            ),
          ),
          // Challenges Segment
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(challenges[index].title),
                  onTap: () {
                    _showChallengeDialog(challenges[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        onTap: (index) {
          // Handle navigation based on the tapped index
          // For example, you can use Navigator to push a new page
        },
      ),
    );
  }

  // Function to show challenge details dialog
  void _showChallengeDialog(Challenge challenge) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(challenge.title),
          content: Text("Points: ${challenge.points}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle challenge completion (add points to user)
                setState(() {
                  userPoints += challenge.points;
                });
                Navigator.of(context).pop();
              },
              child: Text("Done"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle removing the challenge
                Navigator.of(context).pop();
              },
              child: Text("Remove"),
            ),
          ],
        );
      },
    );
  }
}
