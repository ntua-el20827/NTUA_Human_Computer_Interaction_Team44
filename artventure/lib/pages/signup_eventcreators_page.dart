import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/pages/welcome_page.dart';
import 'package:artventure/pages/login_page.dart';
import '../database/database_helper.dart';
import 'package:artventure/components/appbar.dart';

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

  bool isUsernameRequired = false;
  bool isPasswordRequired = false;
  bool isConfirmPasswordRequired = false;
  bool isEmailRequired = false;
  bool isFullNameRequired = false;

  String passwordMismatchMessage = "";

  signUpec() async {
    if (usernameController.text.isEmpty) {
      setState(() {
        isUsernameRequired = true;
      });
      return;
    }
    if (passwordController.text.isEmpty) {
      setState(() {
        isPasswordRequired = true;
      });
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      setState(() {
        isConfirmPasswordRequired = true;
      });
      return;
    }
    if (emailController.text.isEmpty) {
      setState(() {
        isEmailRequired = true;
      });
      return;
    }
    if (fullNameController.text.isEmpty) {
      setState(() {
        isFullNameRequired = true;
      });
      return;
    }

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        passwordMismatchMessage = "Passwords do not match";
      });
      return;
    }

    var res = await DatabaseHelper().createEventCreator(EventCreator(
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
      fullName: fullNameController.text,
    ));
    if (res > 0) {
      EventCreator? eventCreatorDetails =
          await DatabaseHelper().getEventCreator(usernameController.text);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WelcomePage(profile: eventCreatorDetails)),
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Text(
                        "Enter your details to become Event Creator",
                        style: TextStyle(
                          color: Color.fromARGB(255, 152, 151, 151),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  hint: "Username",
                  icon: Icons.account_circle,
                  controller: usernameController,
                  required: isUsernameRequired,
                ),
                InputField(
                  hint: "Password",
                  icon: Icons.lock,
                  controller: passwordController,
                  passwordInvisible: true,
                  required: isPasswordRequired,
                ),
                InputField(
                  hint: "Re-enter password",
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                  passwordInvisible: true,
                  required: isConfirmPasswordRequired,
                ),
                InputField(
                  hint: "Email",
                  icon: Icons.email,
                  controller: emailController,
                  required: isEmailRequired,
                ),
                InputField(
                  hint: "Full Name",
                  icon: Icons.person,
                  controller: fullNameController,
                  required: isFullNameRequired,
                ),
                const SizedBox(height: 10),
                Button(
                  label: "SIGN UP",
                  press: () {
                    setState(() {
                      isUsernameRequired = false;
                      isPasswordRequired = false;
                      isConfirmPasswordRequired = false;
                      isEmailRequired = false;
                      isFullNameRequired = false;
                      passwordMismatchMessage = ""; // Clear previous error message
                    });
                    signUpec();
                  },
                ),
                
                // Display password mismatch message
                if (passwordMismatchMessage.isNotEmpty)
                  Text(
                    passwordMismatchMessage,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 183, 63, 55),
                      fontSize: 16,
                    ),
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
