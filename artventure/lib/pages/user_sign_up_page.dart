import 'package:flutter/material.dart';
import '../app_routes.dart';
import '../database/artventure_db.dart';
import '../models/user_model.dart';




class UserSignUpPage extends StatefulWidget {
  @override
  _UserSignUpPageState createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  // Controller for text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 

  // Function to handle registration
 void register() async {
  User user = User(
    username: usernameController.text,
    password: passwordController.text,
    // Other properties...
  );

  int result = await ArtventureDB().insertUser(user);
  print('Database Insert Result: $result');

  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ArtVenture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text('If you already have an account, login here.'),
            SizedBox(height: 16),
            TextFieldRow('Username', 'Write here', usernameController),
            TextFieldRow('Password', 'Write here', passwordController, obscureText: true),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldRow extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const TextFieldRow(this.label, this.hint, this.controller,
      {this.obscureText = false, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}