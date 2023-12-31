import 'package:flutter/material.dart';
import 'package:artventure/database/artventure_db.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/app_routes.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    // Fetch user data from the database
    List<User> users = await ArtventureDB().getUsers();
    User? loggedInUser = users.firstWhere(
      (user) => user.username == username && user.password == password,
      //orElse: () => null, // Return null if user is not found
    );

    // ignore: unnecessary_null_comparison
    if (loggedInUser != null) {
      // Navigate to the profile page with the user data
      Navigator.pushNamed(
        context,
        AppRoutes.profilePage,
        arguments: loggedInUser,
      );
    } else {
      // Handle case when user is not found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
