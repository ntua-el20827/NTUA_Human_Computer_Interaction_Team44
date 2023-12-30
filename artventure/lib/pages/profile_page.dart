import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../components/challenge.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    Challenge(
      name: "Visit an Art Gallery",
      info: "Visiting an art gallery is very good",
      points: 20,
    ),
    Challenge(
      name: "Create a Digital Artwork",
      info: "Creating an Artwork is very good",
      points: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).info,
        title: Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Text(
            'ArtVenture',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'MonteCarlo',
                  fontSize: 30,
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
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
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/image_not_found.png'),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _showChallengeDialog(challenges[index]);
                    },
                    child: challenges[index].buildBigCard(context),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
          content: challenge.buildBigCard(context),
        );
      },
    );
  }
}
