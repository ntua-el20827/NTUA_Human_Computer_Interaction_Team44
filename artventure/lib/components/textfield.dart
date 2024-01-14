import 'package:flutter/material.dart';
import 'package:artventure/components/colors_and_fonts.dart';

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
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: required
            ? Border.all(color: Colors.red) // Add a red border if required
            : null,
      ),
      child: Center(
        child: TextFormField(
          obscureText: passwordInvisible,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            icon: Icon(icon),
            errorText: required ? 'Required field' : null, // Add error text if required
          ),
        ),
      ),
    );
  }
}