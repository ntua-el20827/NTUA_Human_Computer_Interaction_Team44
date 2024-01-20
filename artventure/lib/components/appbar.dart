import 'package:artventure/components/colors_and_fonts.dart';
import 'package:flutter/material.dart';

// Custom AppBar for the Artventure-Demo app. Doesn't include logout button
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/music.jpg',
            height: 30,
            width: 35,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Text(
            'ArtVenture-Demo',
            style: TextStyle(
              // Custom font for the title
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
