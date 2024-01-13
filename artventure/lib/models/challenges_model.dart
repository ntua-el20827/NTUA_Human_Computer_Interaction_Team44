import 'dart:convert';

Challenge challengeFromMap(String str) => Challenge.fromMap(json.decode(str));

String challengeToMap(Challenge data) => json.encode(data.toMap());

class Challenge {
  final int? challengeId;
  final String title;
  final int points;
  final String category;
  final String infoText;
  final String? imageFilePath; // Added image field

  Challenge({
    this.challengeId,
    required this.title,
    required this.points,
    required this.category,
    required this.infoText,
    this.imageFilePath,
  });

  factory Challenge.fromMap(Map<String, dynamic> json) => Challenge(
        challengeId: json["challengeId"],
        title: json["title"],
        points: json["points"],
        category: json["category"],
        infoText: json["infoText"],
        imageFilePath: json["imageFilePath"],
      );

  Map<String, dynamic> toMap() => {
        "challengeId": challengeId,
        "title": title,
        "points": points,
        "category": category,
        "infoText": infoText,
        "imageFilePath": imageFilePath,
      };
}
