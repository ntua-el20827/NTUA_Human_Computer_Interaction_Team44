import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/pages/login_page.dart';
import 'package:artventure/pages/signup_page.dart';
import 'package:artventure/pages/signup_eventcreators_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text('ArtVenture', style: titleLarge),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Explore the world of art",
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(child: Image.asset("assets/startup.jpg")),
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
