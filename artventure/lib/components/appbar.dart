import 'package:artventure/components/colors_and_fonts.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Removes the back button
      backgroundColor: primaryColor,
      centerTitle: true, // Centers the title
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/music.jpg',
            height: 30, // Adjust the height according to your preference
            width: 35, // Adjust the width according to your preference
            fit: BoxFit.contain,
          ),
          const SizedBox(
              width: 8), // Adjust the spacing according to your preference
          Text(
            'ArtVenture-Demo',
            style: TextStyle(
              // Use a different font for 'ArtVenture'
              fontSize: 26, // Adjust the font size according to your preference
              fontWeight: FontWeight.bold,
              color:
                  Colors.white, // Adjust the color according to your preference
            ),
          ),
        ],
      ),
    );
  }
}