import 'package:flutter/material.dart';
import 'package:artventure/pages/landing_page.dart';
import 'package:artventure/pages/login_page.dart';
import 'package:artventure/pages/quiz_page.dart';
import 'package:artventure/pages/profile_page.dart';
import 'package:artventure/pages/signup_page.dart';
import 'package:artventure/pages/challenges_page.dart';
import 'package:artventure/pages/signup_eventcreators_page.dart';
import 'package:artventure/pages/welcome_page.dart';
import 'package:artventure/pages/explore_page.dart';

//import 'package:artventure/pages/explore_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String quiz = '/quiz';
  static const String quiz_2 = '/quiz_2';
  static const String profile = '/profile';
  static const String signUp = '/sign_up';
  static const String userSign = '/sign_up';
  static const String userLoginPage = '/login';
  static const String challenges = '/challenges';
  static const String eventcreatorsignup = '/eventcreator_signup';
  static const String welcome = '/welcome';
  static const String explore = '/explore';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      landing: (context) => LandingPage(),
      login: (context) => LoginPage(),
      quiz: (context) => QuizPage(),
      profile: (context) => Profile(),
      signUp: (context) => SignUpPage(),
      challenges: (context) => ChallengesPage(),
      eventcreatorsignup: (context) => SignUpEventCreatorPage(),
      welcome: (context) => WelcomePage(),
      explore: (context) => ExplorePage(),
      //userSign: (context) => UserSignUpPage(),
      //userLoginPage: (context) => UserLoginPage(),
    };
  }
}
