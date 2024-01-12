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
      title: Text(
        'ArtVenture',
        style: titleLarge,
      ),
    );
  }
}
