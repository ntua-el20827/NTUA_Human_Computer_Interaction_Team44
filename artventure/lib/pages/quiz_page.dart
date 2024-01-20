import 'package:artventure/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:artventure/pages/profile_page.dart';
import 'package:artventure/models/user_info_model.dart';
import 'package:artventure/components/appbar.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class QuizPage extends StatelessWidget {
  final int? userId;
  final String? username;

  QuizPage({Key? key, this.userId, this.username}) : super(key: key);
  UserInfo userInfo = UserInfo(userId: 0, favoriteArt: '', artTaste: '');

  final PageController _pageController = PageController();
  final db = DatabaseHelper();

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Function to play the sound
  void _playSound() {
    // Play the sound file (assuming it's in the assets directory)
    _audioPlayer.play(AssetSource('sound/quiz.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Let\'s Play a Small Game...',
            style: TextStyle(
              color: Color.fromARGB(255, 152, 151, 151),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'What is your Favorite Art:',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 152, 151, 151)),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              _playSound();
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
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              _playSound();
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
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              _playSound();
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
        SizedBox(height: 10.0),
        Container(
          width: 200.0, // Adjust the width as needed
          child: ElevatedButton(
            onPressed: () {
              _playSound();
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30.0),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Let\'s Play a Small Game...',
            style: TextStyle(
              color: Color.fromARGB(255, 152, 151, 151),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 50.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Describe your art taste:',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 152, 151, 151)),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the profile page after clicking the last answer
              // Now the user profile has been created based on the user's answers
              _playSound();
              userInfo.artTaste = 'Classic';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(username: username)),
              );
            },
            child: Text('A. Classic'),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              _playSound();
              userInfo.artTaste = 'Abstract';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(username: username)),
              );
            },
            child: Text('B. Abstract'),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              _playSound();
              userInfo.artTaste = 'Eclectic';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(username: username)),
              );
            },
            child: Text('C. Eclectic'),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              _playSound();
              userInfo.artTaste = 'Minimalist';
              userInfo.userId = userId!;
              db.saveUserAnswers(userInfo);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile(username: username)),
              );
            },
            child: Text('D. Minimalist'),
          ),
        ),
      ],
    );
  }
}
