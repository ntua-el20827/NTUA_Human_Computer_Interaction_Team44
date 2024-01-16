//import 'package:artventure/components/appbar.dart';
import 'package:artventure/components/appbar_with_logout.dart';
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
//import 'package:fluttertoast/fluttertoast.dart';
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
      appBar: CustomAppBar_with_logout(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(
                      16.0), // Add padding to provide space around the contents
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 217, 180, 229),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 117, 12, 87).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Adjust alignment if needed
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Adjust alignment if needed
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 57,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage(() {
                            switch (_userInfo?.favoriteArt) {
                              case 'Theater':
                                return 'assets/avatars/theater_avatar.jpg';
                              case 'Dance':
                                return 'assets/avatars/dance_avatar.jpg';
                              case 'Visual Arts':
                                return 'assets/avatars/visual_arts_avatar.jpg';
                              case 'Music':
                                return 'assets/avatars/music_avatar.jpg';
                              default:
                                return 'assets/avatars/no_user.jpg';
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
                                "${widget.username}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "An ${getArtTasteNickname(_userInfo?.artTaste)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Points: ${_userProfile?.points}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
          return Text('You haven\'t complete any challenges yet.');
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              if (inProgressChallenges.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "To Do Challenges",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Completed Challenges",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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
                image: 'assets/${challenge?.imageFilePath}',
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
            TextButton(
              onPressed: () {
                _makePointsZero();
                Navigator.of(context).pop();
                _loadUserInfo();
              },
              child: Text("Redeem"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _makePointsZero() async {
    await DatabaseHelper().updateUserPoints(widget.username!, 0);
    //String partyImagePath = "assets/congrats.jpg"; // Customize image path
    // Fluttertoast.showToast(
    //   msg:
    //       "Congratulations!! \nYou have collected your Reward! \nWe hope you have fun!",
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    //   timeInSecForIosWeb: 1,
    // );

    // Delay for 1 second and then close the popup
    //await Future.delayed(Duration(seconds: 1));

    //Navigator.of(context).pop(); // Close the dialog
  }
}

// Add this method to get the correct avatar image path based on favorite art

String getArtTasteNickname(String? artTaste) {
  switch (artTaste) {
    case 'Classic':
      return "ClassicArtDevotee";
    case 'Abstract':
      return "AbstractArtEnthusiast";
    case 'Eclectic':
      return "EclecticArtAficionado";
    case 'Minimalist':
      return "MinimalistArtFanatic";
    default:
      return "ArtLover"; // Default case if none of the above matches
  }
}
