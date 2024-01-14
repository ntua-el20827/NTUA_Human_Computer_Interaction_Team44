import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/user_model.dart';
import 'package:artventure/pages/quiz_page.dart';
import 'package:artventure/pages/login_page.dart';
import 'package:artventure/components/appbar.dart';
import '../database/database_helper.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usrName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final db = DatabaseHelper();

  bool isPasswordsMismatch = false;

  signUp() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Check if passwords match
    if (password.text != confirmPassword.text) {
      setState(() {
        isPasswordsMismatch = true;
      });
      return;
    }

    int userId = await db.createUser(Users(username: usrName.text, password: password.text));
    print("UserID in signup");
    print(userId);

    if (userId > 0) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuizPage(userId: userId, username: usrName.text),
        ),
      );
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
                      "Become an ArtVenturer",
                      style: TextStyle(
                        color: Color.fromARGB(255, 152, 151, 151),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "All you have to do is Sign Up below",
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
              SizedBox(height: 8),
              InputField(
                hint: "Re-enter password",
                icon: Icons.lock,
                controller: confirmPassword,
                passwordInvisible: true,
              ),
              SizedBox(height: 40),
              Button(
                label: "SIGN UP",
                press: () {
                  signUp();
                },
              ),
              // Display error message conditionally
              if (isPasswordsMismatch)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Passwords don't match",
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
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text("LOGIN"),
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
