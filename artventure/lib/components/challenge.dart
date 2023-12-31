import 'package:flutter/material.dart';

enum ChallengeState {
  open,
  inProgress,
  done,
}

class Challenge {
  final String name;
  final String info;
  final int points;
  final String image;
  final List<String> categories;
  ChallengeState state;

  Challenge({
    required this.name,
    required this.info,
    required this.points,
    required this.categories,
    required this.state,
    required this.image,
  });

  Widget buildSmallChallengeCard() {
    return Card(
      child: Column(
        children: [
          Image.network(
            image.isNotEmpty ? image : 'assets/images/image_not_found.png',
            fit: BoxFit.cover,
            height: 50.0,
          ),
          ListTile(
            title: Text(name),
            subtitle: Text(info),
          ),
        ],
      ),
    );
  }

  Widget buildMediumChallengeCard() {
    return Card(
      child: Column(
        children: [
          Image.network(
            image.isNotEmpty ? image : 'assets/images/image_not_found.png',
            fit: BoxFit.cover,
            height: 75.0,
          ),
          ListTile(
            title: Text(name),
            subtitle: Text(info),
          ),
        ],
      ),
    );
  }

  Widget buildLargeChallengeCard({
    required Function() onButton1Pressed,
    required Function() onButton2Pressed,
  }) {
    return Card(
      child: Column(
        children: [
          Image.network(
            image.isNotEmpty ? image : 'assets/images/image_not_found.png',
            fit: BoxFit.cover,
            height: 100.0,
          ),
          ListTile(
            title: Text(name),
            subtitle: Text(info),
          ),
          if (state == ChallengeState.open)
            ButtonBar(
              children: [
                TextButton(
                  onPressed: onButton1Pressed,
                  child: Text('Start'),
                ),
              ],
            ),
          if (state == ChallengeState.inProgress)
            ButtonBar(
              children: [
                TextButton(
                  onPressed: onButton1Pressed,
                  child: Text('Continue'),
                ),
              ],
            ),
          if (state == ChallengeState.done)
            ButtonBar(
              children: [
                TextButton(
                  onPressed: onButton1Pressed,
                  child: Text('View Results'),
                ),
              ],
            ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: onButton2Pressed,
                child: Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
