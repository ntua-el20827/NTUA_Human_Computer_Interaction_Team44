// app_routes.dart

import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/quiz_page.dart';
import 'pages/profile_page.dart';

class AppRoutes {
  static const String landing = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String quiz = '/quiz';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      landing: (context) => LandingPage(),
      register: (context) => RegisterPage(),
      login: (context) => LoginPage(),
      quiz: (context) => QuizPage(),
      profile: (context) => ProfilePage(),
    };
  }
}
