import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/pages/login_page.dart';
import 'package:artventure/pages/signup_page.dart';
import 'package:artventure/pages/signup_eventcreators_page.dart';
import 'package:artventure/components/appbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Explore The World of Art",
                  style: TextStyle(
                      color: Color.fromARGB(255, 97, 97, 97),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 250, // Set your desired height
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8), // Adjust the radius as needed
                    child: Image.asset("assets/startup.jpg", fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 30),
                Button(
                  label: "LOGIN",
                  press: () {
                    // Extra: Search for DeviceID and if yes then go straight to profile:
                    // var res = DatabaseHelper().searchForDeviceID()
                    // If res:
                    //  Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => Profile(username: username)),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
                Button(
                  label: "SIGN UP",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                ),
                Button(
                  label: "BECOME AN EVENT CREATOR",
                  press: () {
                    // Handle navigation to the 'Become an Event Creator' screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpEventCreatorPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
