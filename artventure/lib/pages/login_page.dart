import 'package:artventure/pages/profile_page.dart';
import 'package:artventure/pages/signup_page.dart';
import 'package:artventure/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/components/appbar.dart';

import '../database/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;
  String errorMessage = "";

  final db = DatabaseHelper();

  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    var res = await db.authenticate(Users(username: usrName.text, password: password.text));

    if (res == true) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile(username: usrDetails?.username)),
      );
    } else {
      EventCreator? eventCreatorDetails = await db.getEventCreator(usrName.text);
      var eventCreatorRes = await db.authenticate_ec(usrName.text, password.text);

      if (eventCreatorRes == true) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage(profile: eventCreatorDetails)),
        );
      } else {
        setState(() {
          isLoginTrue = true;
          errorMessage = "Invalid username or password"; // Set your error message here
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  children: [
                    Text(
                      "Welcome back to ArtVenture",
                      style: TextStyle(
                        color: Color.fromARGB(255, 152, 151, 151),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Please Login to Continue",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              InputField(
                hint: "Username",
                icon: Icons.account_circle,
                controller: usrName,
              ),
              SizedBox(height: 8),
              InputField(
                hint: "Password",
                icon: Icons.lock,
                controller: password,
                passwordInvisible: true,
              ),
              
              SizedBox(height: 40),
              Button(
                label: "LOGIN",
                press: () {
                  login();
                },
              ),
              
              // Display error message conditionally
              if (isLoginTrue)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 183, 63, 55),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text("SIGN UP"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
