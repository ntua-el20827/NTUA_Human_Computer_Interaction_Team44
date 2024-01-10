import 'package:artventure/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/database/database_helper.dart';
import 'package:artventure/components/bottom_navigation_bar.dart';

class Profile extends StatefulWidget {
  final String? username;

  const Profile({Key? key, this.username}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Users? _userProfile;
  UserInfo? _userInfo;

  @override
  void initState() {
    super.initState();
    // Load user information when the page initializes
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = await DatabaseHelper().getUser(widget.username!);
    final userinfo = await DatabaseHelper().getUserInfo(user?.userId);
    if (user != null) {
      setState(() {
        _userProfile = user;
        _userInfo = userinfo;
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
                            Text("Favorite Art: ${_userInfo?.favoriteArt}"),
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
                  subtitle: Text(AutofillHints.username),
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
      bottomNavigationBar: BottomNavBar(username: widget.username),
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
