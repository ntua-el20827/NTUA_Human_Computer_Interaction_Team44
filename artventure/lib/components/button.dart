import 'package:flutter/material.dart';
import 'package:artventure/components/colors_and_fonts.dart';

// Button as a component

class Button extends StatelessWidget {
  // attributes
  final String label;
  final VoidCallback press;
  const Button({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: size.width * .9,
      height: 55,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        onPressed: press,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
