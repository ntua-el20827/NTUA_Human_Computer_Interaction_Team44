// app_routes.dart

import 'package:flutter/material.dart';
import 'package:artventure/pages/landing_page.dart';
import 'package:artventure/pages/login_page.dart';
// import 'package:artventure/pages/quiz_page.dart';
import 'package:artventure/pages/profile_page.dart';
import 'package:artventure/pages/signup_page.dart';

class AppRoutes {
  static const String landing = '/';

  static const String login = '/login';
  static const String quiz = '/quiz';
  static const String profilePage = '/profile';
  static const String signUp = '/sign_up';
  static const String userSign = '/sign_up';
  static const String userLoginPage = '/login';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      landing: (context) => LandingPage(),
      login: (context) => LoginPage(),
      //quiz: (context) => QuizPage(),
      profilePage: (context) => Profile(),
      signUp: (context) => SignUpPage(),
      //userSign: (context) => UserSignUpPage(),
      //userLoginPage: (context) => UserLoginPage(),
    };
  }
}
