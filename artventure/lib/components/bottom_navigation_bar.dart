import 'package:flutter/material.dart';
import 'package:artventure/app_routes.dart';

// Base Class
class BottomNavBar extends StatefulWidget {
  final String? username;

  const BottomNavBar({this.username});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

// Extended Class
class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(
              context,
              AppRoutes.profile,
              arguments: {'username': widget.username},
            );
            break;
          case 1:
            Navigator.pushNamed(
              context,
              AppRoutes.challenges,
              arguments: {'username': widget.username},
            );
            break;
          case 2:
            Navigator.pushNamed(
              context,
              AppRoutes.explore,
              arguments: {'username': widget.username},
            );
            break;
        }
      },
    );
  }
}
