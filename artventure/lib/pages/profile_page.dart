import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/database/database_helper.dart';

class Profile extends StatefulWidget {
  final Users? profile;

  const Profile({super.key, this.profile});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Users? _userProfile;

  @override
  void initState() {
    super.initState();
    // Load user information when the page initializes
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = await DatabaseHelper().getUser(widget.profile!.username);
    if (user != null) {
      setState(() {
        _userProfile = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 77,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/no_user.jpg"),
                        radius: 75,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Points: ${_userProfile?.points}"),
                            Text(
                                "FavoriteArt: ${_userProfile?.userinfo[0] ?? ""}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Button(
                  label: "myPoints",
                  press: () {
                    _showPointsRedemptionPopup(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle, size: 30),
                  subtitle: Text(_userProfile!.username),
                  title: const Text("Hello ArtVenturer!"),
                ),
                const SizedBox(height: 20),
                _buildChallengesSection(),
                _buildEventsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChallengesSection() {
    return Column(
      children: [
        const Text(
          "My Challenges",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildEventsSection() {
    return Column(
      children: [
        const Text(
          "Favorite Events",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _showPointsRedemptionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Points Redemption"),
          content: Column(
            children: [
              const Text("Scan This to Collect Prize!!"),
              const Text("Your QR Code Here"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
