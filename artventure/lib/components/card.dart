import 'package:flutter/material.dart';

// Basic Idea of the Card as a component

class MyCard extends StatelessWidget {
  final int challengeId;
  final int userId;
  final String status;

  MyCard(
      {required this.challengeId, required this.userId, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text('Challenge ID: $challengeId'),
            subtitle: Text('User ID: $userId\nStatus: $status'),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: Text('ACTION 1'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('ACTION 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
