import 'package:flutter/material.dart';
import 'package:artventure/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.profile);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.challenges);
            break;
          case 2:
            //Navigator.pushNamed(context, AppRoutes.explore);
            break;
        }
      },
    );
  }
}
