import 'package:artventure/pages/challenges_page.dart';
import 'package:artventure/pages/explore_page.dart';
import 'package:artventure/pages/explore_page2.dart';
import 'package:artventure/pages/profile_page.dart';
import 'package:flutter/material.dart';
//import 'package:artventure/app_routes.dart';

// Base Class
class BottomNavBar extends StatefulWidget {
  final String? username;

  const BottomNavBar({super.key, this.username});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

// Extended Class
class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("bottom navbar");
    print(widget.username);
    return BottomNavigationBar(
      currentIndex: currentIndex,
      // The selected color is not working!
      selectedItemColor: Color.fromARGB(255, 124, 14, 134),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Challenges',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded),
          label: 'Explore',
        ),
      ],
      onTap: (index) {
        // Only navigate if the selected tab is different
        setState(() {
          currentIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(username: widget.username),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChallengesPage(username: widget.username),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExplorePage2(username: widget.username),
              ),
            );
            break;
        }
      },
    );
  }
}

class Explore {}

class Challenges {}
