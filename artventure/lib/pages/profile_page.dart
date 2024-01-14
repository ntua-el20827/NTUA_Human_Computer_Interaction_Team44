import 'package:artventure/components/appbar.dart';
import 'package:artventure/components/big_card.dart';
import 'package:artventure/components/small_card.dart';
import 'package:artventure/models/challenges_model.dart';
import 'package:artventure/models/user_challenges_model.dart';
import 'package:artventure/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/database/database_helper.dart';
import 'package:artventure/components/bottom_navigation_bar.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:artventure/components/card.dart';

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

    if (user == null) {
      //print("User not found for username: ${widget.username}");
      return;
    }
    int? userId = await DatabaseHelper().getUserId(widget.username!);
    print(userId);
    final userinfo = await DatabaseHelper().getUserInfo(userId!);

    // print(user.userId);
    // print("User: $user");
    // print("UserInfo: $userinfo");
    print(_userInfo?.artTaste);

    setState(() {
      _userProfile = user;
      _userInfo = userinfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("profile");
    print(widget.username);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 57,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage(() {
                          switch (_userInfo?.favoriteArt) {
                            /*case 'Music':
                            return 'assets/music_avatar.jpg';*/
                            case 'Theater':
                              return 'assets/theater_avatar.jpg';
                            case 'Dance':
                              return 'assets/dance_avatar.jpg';
                            case 'Visual Arts':
                              return 'assets/visual_arts_avatar.jpg';
                            default:
                              return 'assets/no_user.jpg';
                          }
                        }()),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ArtVenturer ${widget.username}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "A ${getArtTasteNickname(_userInfo?.artTaste)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Points: ${_userProfile?.points}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Button(
                  label: "Redeem my Points",
                  press: () {
                    _showPointsRedemptionPopup(context);
                  },
                ),
                const SizedBox(height: 20),
                _buildChallengesSection(),
                _buildEventsSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        username: widget.username,
        currentIndex: 0,
      ),
    );
  }

  Widget _buildChallengesSection() {
    return FutureBuilder<List<UserChallenges>>(
      future: DatabaseHelper().getUserChallenges(widget.username!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No challenges in progress.');
        } else {
          List<UserChallenges> userChallenges = snapshot.data!;

          // Filter challenges based on status
          List<UserChallenges> doneChallenges = userChallenges
              .where((challenge) => challenge.status == "done")
              .toList();
          List<UserChallenges> inProgressChallenges = userChallenges
              .where((challenge) => challenge.status == "inprogress")
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Challenges",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (inProgressChallenges.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "In Progress",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: inProgressChallenges.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Challenge?>(
                          future: DatabaseHelper().getChallenge(
                              inProgressChallenges[index].challengeId),
                          builder: (context, challengeSnapshot) {
                            if (challengeSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (challengeSnapshot.hasError) {
                              return Text('Error: ${challengeSnapshot.error}');
                            } else {
                              Challenge? challenge = challengeSnapshot.data;
                              return SmallCard(
                                title: challenge?.title ?? 'Unknown Title',
                                category:
                                    challenge?.category ?? 'Unknown Category',
                                points: challenge?.points ?? 0,
                                onPressed: () {
                                  // In progress challenges will be shown as big cards
                                  _showBigCard(context, challenge);
                                  print("In Progress Challenge tapped");
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              if (doneChallenges.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Done",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: doneChallenges.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Challenge?>(
                          future: DatabaseHelper()
                              .getChallenge(doneChallenges[index].challengeId),
                          builder: (context, challengeSnapshot) {
                            if (challengeSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (challengeSnapshot.hasError) {
                              return Text('Error: ${challengeSnapshot.error}');
                            } else {
                              Challenge? challenge = challengeSnapshot.data;
                              return SmallCard(
                                title: challenge?.title ?? 'Unknown Title',
                                category:
                                    challenge?.category ?? 'Unknown Category',
                                points: challenge?.points ?? 0,
                                onPressed: () {
                                  // Handle the tap on the done challenge card (show big card).
                                  // Add your logic here.
                                  // You may want to navigate to a new page or show a dialog.
                                  print("Done Challenge tapped");
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
            ],
          );
        }
      },
    );
  }

  void _showBigCard(BuildContext context, Challenge? challenge) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              BigCard(
                image: 'assets${challenge?.imageFilePath}',
                title: challenge!.title,
                category: challenge.category,
                info: challenge.infoText,
                points: challenge.points,
                firstButtonLabel: 'Done',
                firstButtonAction: () {
                  _markChallengeAsDone(challenge.challengeId, challenge.points);
                  Navigator.pop(context);
                },
                secondButtonLabel: 'Remove',
                secondButtonAction: () {
                  removeChallengeFromUserChallenge(challenge.challengeId);
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 16.0), // To be changed after mano's info
            ],
          ),
        );
      },
    );
  }

  Future<void> _markChallengeAsDone(
      int? challengeId, int? challengePoints) async {
    // Implement the logic to update the challenge status to 'done' in the database
    await DatabaseHelper().changeChallengeStatus(challengeId, 'done');
    int newPoints = (_userProfile!.points + challengePoints!);
    await DatabaseHelper().updateUserPoints(widget.username!, newPoints);
    _loadUserInfo();
  }

  Future<void> removeChallengeFromUserChallenge(int? challengeId) async {
    // Implement the logic to remove the challenge from the user_challenge table in the database
    await DatabaseHelper().removeChallengeFromUserChallenge(challengeId);
    _loadUserInfo();
  }

  ///////////////////////// EVENTS

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

  ///////////////////////// QR CODE

  void _showPointsRedemptionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Points Redemption"),
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.7, // Set your desired maximum width
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Adjust according to your content
              children: [
                const Text("Scan This to Collect Prize!!"),
                Image.asset("assets/qrcode_demo.jpg",
                    fit: BoxFit.cover, height: 240),
              ],
            ),
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

// Add this method to get the correct avatar image path based on favorite art

String getArtTasteNickname(String? artTaste) {
  switch (artTaste) {
    case 'Classic':
      return "ClassicArtDevotee";
    case 'Contemporary':
      return "ContemporaryArtEnthusiast";
    case 'Eclectic':
      return "EclecticArtAficionado";
    case 'Minimalist':
      return "MinimalistArtFanatic";
    default:
      return "ArtLover"; // Default case if none of the above matches
  }
}
