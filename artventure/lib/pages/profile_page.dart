import 'package:artventure/components/challenge.dart';
import 'package:flutter/material.dart';

class Profile {
  final String name;
  final String favoriteArt;
  final String personality;
  final int points;
  final String
      avatar; // You might replace this with the actual user avatar data from the database

  Profile({
    required this.name,
    required this.favoriteArt,
    required this.personality,
    required this.points,
    required this.avatar,
  });
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample user profile
  Profile userProfile = Profile(
    name: 'John Doe',
    favoriteArt: 'Impressionism',
    personality: 'Art Enthusiast',
    points: 150,
    avatar: 'path_to_avatar_image', // Replace with actual avatar data
  );

  // Sample list of challenges
  List<Challenge> challenges = [
    Challenge(
        name: 'Challenge 1',
        info: 'Description for Challenge 1',
        points: 20,
        categories: ['Category 1'],
        state: ChallengeState.inProgress,
        image:
            'https://en.wikipedia.org/wiki/Art#/media/File:Art-portrait-collage_2.jpg' // Replace with actual image data
        ),
    Challenge(
        name: 'Challenge 2',
        info: 'Description for Challenge 2',
        points: 30,
        categories: ['Category 2'],
        state: ChallengeState.done,
        image:
            'https://en.wikipedia.org/wiki/Art#/media/File:Art-portrait-collage_2.jpg' // Replace with actual image data
        ),
    // Add more challenges as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArtVenture'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Info Segment
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.blue, // Add your desired color
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Profile Info',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(userProfile.avatar),
                  ),
                  SizedBox(height: 16.0),
                  Text('Name: ${userProfile.name}'),
                  Text('Favorite Art: ${userProfile.favoriteArt}'),
                  Text('Personality: ${userProfile.personality}'),
                  Text('Points: ${userProfile.points}'),
                ],
              ),
            ),

            // Challenges Segment
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Challenges',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  // In Progress Challenges
                  Text('In Progress Challenges',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(
                    children: challenges
                        .where((challenge) =>
                            challenge.state == ChallengeState.inProgress)
                        .map((challenge) => userProfileCard(challenge))
                        .toList(),
                  ),
                  SizedBox(height: 16.0),
                  // Done Challenges
                  Text('Done Challenges',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(
                    children: challenges
                        .where((challenge) =>
                            challenge.state == ChallengeState.done)
                        .map((challenge) => userProfileCard(challenge))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
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
          // Handle navigation to different pages
        },
      ),
    );
  }

  Widget userProfileCard(Challenge challenge) {
    return GestureDetector(
      onTap: () {
        showChallengePopup(challenge);
      },
      child: Card(
        // Your card styling here
        child: Column(
          children: [
            Image.asset(
              challenge.image.isNotEmpty
                  ? challenge.image
                  : 'assets/images/default_image.png',
              fit: BoxFit.cover,
              height: 50.0,
            ),
            ListTile(
              title: Text(challenge.name),
              subtitle: Text(challenge.info),
            ),
          ],
        ),
      ),
    );
  }

  void showChallengePopup(Challenge challenge) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(challenge.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                challenge.image.isNotEmpty
                    ? challenge.image
                    : 'assets/images/default_image.png',
                fit: BoxFit.cover,
                height: 100.0,
              ),
              Text(challenge.info),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Handle "Done" button press
                setState(() {
                  challenge.state = ChallengeState.done;
                });
                Navigator.pop(context);
              },
              child: Text('Done'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle "Remove" button press
                setState(() {
                  challenge.state = ChallengeState.open;
                });
                Navigator.pop(context);
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
