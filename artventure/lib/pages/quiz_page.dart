import 'package:artventure/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/pages/profile_page.dart';
import 'package:artventure/models/user_info_model.dart';

// ignore: must_be_immutable
class QuizPage extends StatelessWidget {
  final int? userId;
  final String? username;

  QuizPage({Key? key, this.userId, this.username}) : super(key: key);
  UserInfo userInfo = UserInfo(userId: 0, favoriteArt: '', artTaste: '');

  final PageController _pageController = PageController();
  final db = DatabaseHelper();
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
      body: PageView(
        controller: _pageController,
        children: [
          buildQuizPage(context),
          buildQuizPage2(context),
          //buildQuizPage3(context),
          //buildQuizPage4(context),
        ],
      ),
    );
  }

  Widget buildQuizPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(
            'Let\'s Play a Small Game...',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(height: 20.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'What is your Favorite Art:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              userInfo.favoriteArt = 'Visual Arts';
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text('A. Visual ARTs'),
          ),
        ),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              userInfo.favoriteArt = 'Music';
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text('B. Music'),
          ),
        ),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              userInfo.favoriteArt = 'Dance';
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text('C. Dance'),
          ),
        ),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              userInfo.favoriteArt = 'Theater';
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text('D. Theater'),
          ),
        ),
        // Add more answer options as needed
      ],
    );
  }

  Widget buildQuizPage2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Let\'s Play a Small Game...',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(height: 20.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'If you could describe your art taste in one word, what would it be?',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the profile page after clicking the last answer
              userInfo.artTaste = 'Classic';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                        username:
                            username)), // Replace ProfilePage with your actual profile page
              );
            },
            child: Text('A. Classic'),
          ),
        ),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the profile page after clicking the last answer
              userInfo.artTaste = 'Contemporary';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                        username:
                            username)), // Replace ProfilePage with your actual profile page
              );
            },
            child: Text('B. Contemporary'),
          ),
        ),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the profile page after clicking the last answer
              userInfo.artTaste = 'Eclectic';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                        username:
                            username)), // Replace ProfilePage with your actual profile page
              );
            },
            child: Text('C. Eclectic'),
          ),
        ), // Add more answer options as needed
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the profile page after clicking the last answer
              userInfo.artTaste = 'Minimalist';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(
                        username:
                            username)), // Replace ProfilePage with your actual profile page
              );
            },
            child: Text('D. Minimalist'),
          ),
        ),
      ],
    );
  }
}
