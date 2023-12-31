// app_routes.dart

import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
//import 'pages/login_page.dart';
import 'pages/quiz_page.dart';
import 'pages/profile_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/user_sign_up_page.dart';

class AppRoutes {
  static const String landing = '/';
  
  static const String login = '/login';
  static const String quiz = '/quiz';
  static const String profile = '/profile';
  static const String sign = '/sign_up';
  static const String userSign = '/user_sign_up';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      landing: (context) => LandingPage(),
      
      //login: (context) => LoginPage(),
      quiz: (context) => QuizPage(),
      profile: (context) => ProfilePage(),
      sign: (context) => SignUpPage(),
      userSign: (context) => UserSignUpPage(),
    };
  }
}
