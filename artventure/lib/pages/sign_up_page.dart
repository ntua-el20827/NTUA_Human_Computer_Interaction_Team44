import 'package:flutter/material.dart';
import '../app_routes.dart';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controller for text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  // Function to handle registration
  void register() {
    // Add your logic to send data to the database
    // For now, let's print the values
    print('Username: ${usernameController.text}');
    print('Password: ${passwordController.text}');
    print('Email: ${emailController.text}');
    print('Fullname: ${fullnameController.text}');
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
            TextFieldRow('Email', 'Write here', emailController, keyboardType: TextInputType.emailAddress),
            TextFieldRow('Fullname', 'Write here', fullnameController),
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
