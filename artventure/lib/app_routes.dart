import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String register = '/register';
  static const String login = '/login';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      home: (context) => HomePageWidget(),
      register: (context) => RegisterPage(),
      login: (context) => LoginPage(),
    };
  }
}
