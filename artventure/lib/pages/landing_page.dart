import 'package:artventure/pages/user_sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import '../components/custom_button.dart';

import 'quiz_page.dart';
import 'profile_page.dart';
import 'sign_up_page.dart';

class LandingPage extends StatelessWidget {
  void _navigateToQuizPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QuizPage(),
      ),
    );
  }

  // void _navigateToProfilePage(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => ProfilePage(),
  //     ),
  //   );
  // }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  void _navigateToUserSignUpPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserSignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).info,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).info,
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            'ArtVenture',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'MonteCarlo',
                  fontSize: 30,
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Welcome to ArtVenture',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            CustomButton(
              onPressed: () {
                print('Register button pressed ...');
                _navigateToSignUpPage(context);
              },
              text: 'Register to Create Events',
              color: FlutterFlowTheme.of(context).alternate,
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                print('Continue button pressed ...');
                _navigateToQuizPage(context);
              },
              text: 'Signed in User',
              color: FlutterFlowTheme.of(context).secondary,
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                print('Go to Profile button pressed ...');
                _navigateToUserSignUpPage(context);
              },
              text: 'New User',
              color: FlutterFlowTheme.of(context).primary,
            ),
          ],
        ),
      ),
    );
  }
}
