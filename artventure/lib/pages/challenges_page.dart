import 'package:artventure/components/appbar.dart';
import 'package:artventure/components/big_card.dart';
import 'package:artventure/components/medum_card.dart';
import 'package:artventure/models/challenges_model.dart';
import 'package:artventure/models/user_challenges_model.dart';
import 'package:artventure/pages/explore_page2.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/bottom_navigation_bar.dart';
import '../database/database_helper.dart';

class ChallengesPage extends StatefulWidget {
  final String? username;

  const ChallengesPage({Key? key, this.username}) : super(key: key);

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  late List<Challenge> challenges = [];
  List<String> selectedCategories = [];
  List<int> userChallengesIds = [];

  Future<void> fetchChallenges() async {
    // Use the DatabaseHelper to get the challenges
    DatabaseHelper dbHelper = DatabaseHelper();
    challenges = await dbHelper.getAllChallenges();
    // Get user_challenges ids
    List<UserChallenges> userChallenges =
        await dbHelper.getUserChallenges(widget.username!);
    userChallengesIds = userChallenges
        .map((userChallenge) => userChallenge.challengeId)
        .toList();

    // re-render of the UI
    if (mounted) {
      setState(() {});
    }
  }

  // Get unique categories from the list of challenges
  List<String> getUniqueCategories() {
    return challenges.map((challenge) => challenge.category).toSet().toList();
  }

  Future<void> initialLoadChallenges() async {
    // Initial Load
    // Get all Challenges
    DatabaseHelper dbHelper = DatabaseHelper();
    challenges = await dbHelper.getAllChallenges();
    // Get all user challenge ids
    List<UserChallenges> userChallenges =
        await dbHelper.getUserChallenges(widget.username!);
    userChallengesIds = userChallenges
        .map((userChallenge) => userChallenge.challengeId)
        .toList();
    if (mounted) {
      setState(() {});
    }
    // Mark all selected categories
    selectedCategories = getUniqueCategories();
  }

  @override
  void initState() {
    super.initState();
    // Load user information when the page initializes
    initialLoadChallenges();
  }

  // Show the filter drawer
  void showFilterDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void applyFilters() {
              Navigator.pop(context); // Close the drawer
              // Fetch challenges based on selected categories
              fetchChallenges();
            }

            return WillPopScope(
              onWillPop: () async {
                applyFilters();
                return true;
              },
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Filter Challenges',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Display checkboxes for each category (in unique categories)
                    for (String category in getUniqueCategories())
                      CheckboxListTile(
                        title: Text(category),
                        value: selectedCategories.contains(category),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                selectedCategories.add(category);
                              } else {
                                selectedCategories.remove(category);
                              }
                            }
                          });
                        },
                      ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: applyFilters,
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                      ),
                      child: Text('Apply Filters'),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

// Show the challenge details popup
  Future<void> showChallengeDetailsPopup(
    BuildContext context,
    Challenge challenge,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              BigCard(
                image: 'assets/${challenge.imageFilePath}',
                title: challenge.title,
                category: challenge.category,
                info: challenge.infoText,
                points: challenge.points,
                firstButtonLabel: 'Add to My List',
                firstButtonAction: () {
                  addToMyChallenges(widget.username!, challenge);
                  Navigator.pop(context);
                },
                secondButtonLabel: 'Explore around you',
                secondButtonAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ExplorePage2(username: widget.username),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0), // To be changed after mano's info
            ],
          ),
        );
      },
    );
  }

  // Add the challenge to the user_challenge table with status "inprogress"
  Future<void> addToMyChallenges(String username, Challenge challenge) async {
    // Use the DatabaseHelper to add the challenge to user_challenge
    DatabaseHelper dbHelper = DatabaseHelper();

    // Retrieve userId based on the username
    int? userId = await dbHelper.getUserId(username);

    if (userId != null) {
      UserChallenges userChallenge = UserChallenges(
        challengeId: challenge.challengeId!,
        userId: userId,
        status: 'inprogress',
      );

      await dbHelper.insertUserChallenge(userChallenge);
      fetchChallenges();
    } else {
      // UserId is not found
      print('User not found for username: $username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Text(
                    'ArtVenture Challenges',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: Text(
                    'Discover exciting challenges in music, theater, dance, and visual arts. Earn points and enjoy exclusive art events on-the-go!',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Expanded(
            // ignore: unnecessary_null_comparison
            child: challenges != null
                ? ListView.builder(
                    itemCount: challenges.length,
                    itemBuilder: (context, index) {
                      // Check if the challenge's category is selected
                      if (selectedCategories
                              .contains(challenges[index].category) &&
                          !userChallengesIds
                              .contains(challenges[index].challengeId)) {
                        return MediumCard(
                          image: 'assets/${challenges[index].imageFilePath}',
                          // All images are stored in assets folder
                          title: challenges[index].title,
                          category: challenges[index].category,
                          points: challenges[index].points,
                          onTap: () {
                            // Call the function to show challenge details popup
                            showChallengeDetailsPopup(
                                context, challenges[index]);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        username: widget.username,
        currentIndex: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFilterDrawer(context);
        },
        child: Icon(Icons.filter_alt_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
