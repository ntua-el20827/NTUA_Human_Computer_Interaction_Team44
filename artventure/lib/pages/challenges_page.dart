//// TO FIX: Δεν δείχνει στην αρχή όλες τις κατηγορίες

import 'package:artventure/components/medum_card.dart';
import 'package:artventure/models/challenges_model.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/bottom_navigation_bar.dart';
import '../database/database_helper.dart';

class ChallengesPage extends StatefulWidget {
  final String? username;
  const ChallengesPage({super.key, this.username});

  @override
  _ChallengesPageState createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  late List<Challenge> challenges = [];
  List<String> selectedCategories = [];

  Future<void> fetchChallenges() async {
    // Use your DatabaseHelper class to get the challenges
    DatabaseHelper dbHelper = DatabaseHelper();
    challenges = await dbHelper.getAllChallenges();

    // Force a re-render of the UI after fetching the challenges
    if (mounted) {
      setState(() {});
    }
    print('Selected Categories: $selectedCategories');
    print('Challenges: $challenges');
  }

  // Function to get unique categories from the list of challenges
  List<String> getUniqueCategories() {
    return challenges.map((challenge) => challenge.category).toSet().toList();
  }

  @override
  void initState() {
    super.initState();
    // Fetch challenges with all categories selected
    fetchChallenges();
    selectedCategories = getUniqueCategories();
  }

// Function to show the filter drawer
  void showFilterDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true, // Allow dismissing by clicking outside
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
                applyFilters(); // Call the applyFilters method when the drawer is dismissed
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
                    // Display checkboxes for each category
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
                      onPressed: applyFilters, // Call the applyFilters method
                      child: Text('Apply Filters'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Challenges'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to Challenges',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
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
                          .contains(challenges[index].category)) {
                        return MediumCard(
                          image: 'assets/${challenges[index].imageFilePath}',
                          title: challenges[index].title,
                          category: challenges[index].category,
                          points: challenges[index].points,
                        );
                      } else {
                        return Container(); // Return an empty container if not selected
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
        username: AutofillHints.username,
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
