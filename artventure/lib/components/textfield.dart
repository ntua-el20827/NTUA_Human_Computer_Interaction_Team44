import 'package:flutter/material.dart';
import 'package:artventure/components/colors_and_fonts.dart';

// Used for the login and register pages.
// We worked inspired by this tutorial: https://www.youtube.com/watch?v=tSGOQ_BEd-0&t=546s

class InputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool passwordInvisible;
  final TextEditingController controller;
  final bool required;

  const InputField({
    Key? key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.passwordInvisible = false,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: size.width * .9,
      height: 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: required ? Border.all(color: Colors.red) : null,
              ),
              child: TextFormField(
                obscureText: passwordInvisible,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  prefixIcon: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(icon),
                  ),
                ),
              ),
            ),
          ),
          if (required)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Required field',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
