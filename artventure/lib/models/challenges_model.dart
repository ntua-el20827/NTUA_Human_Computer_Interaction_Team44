import 'dart:convert';

Challenges challengesFromMap(String str) =>
    Challenges.fromMap(json.decode(str));

String challengesToMap(Challenges data) => json.encode(data.toMap());

class Challenges {
  final int? challengeId;
  final String title;
  final int points;
  final String category;

  Challenges({
    this.challengeId,
    required this.title,
    required this.points,
    required this.category,
  });

  factory Challenges.fromMap(Map<String, dynamic> json) => Challenges(
        challengeId: json["challengeId"],
        title: json["title"],
        points: json["points"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "challengeId": challengeId,
        "title": title,
        "points": points,
        "category": category,
      };
}
