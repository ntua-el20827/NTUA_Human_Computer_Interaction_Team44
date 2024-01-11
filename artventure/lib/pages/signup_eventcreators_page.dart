import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/pages/welcome_page.dart';
import 'package:artventure/pages/login_page.dart';
import '../database/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SignUpEventCreatorPage extends StatefulWidget {
  const SignUpEventCreatorPage({Key? key}) : super(key: key);

  @override
  _SignUpEventCreatorPageState createState() => _SignUpEventCreatorPageState();
}

class _SignUpEventCreatorPageState extends State<SignUpEventCreatorPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final db = DatabaseHelper();

  signUpec() async {
    sqfliteFfiInit(); // Initialize the database factory
    databaseFactory = databaseFactoryFfi; // Set the database factory to use FFI

    var eventCreator = EventCreator(
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
      fullName: fullNameController.text,
    );

    var res = await db.createEventCreator(EventCreator(
        username: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
        fullName: fullNameController.text,
        )
      );
    if (res > 0) {
      if (!mounted) return;
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage(profile: eventCreator)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Enter your details to become an Event Creator",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  hint: "Username",
                  icon: Icons.account_circle,
                  controller: usernameController,
                ),
                InputField(
                  hint: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  passwordInvisible: true,
                ),
                InputField(
                  hint: "Re-enter password",
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                  passwordInvisible: true),
                InputField(
                  hint: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),
                InputField(
                  hint: "Full Name",
                  icon: Icons.person,
                  controller: fullNameController,
                ),
                const SizedBox(height: 10),
                Button(
                  label: "SIGN UP",
                  press: () {
                    signUpec();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
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
      ),
    );
  }
}