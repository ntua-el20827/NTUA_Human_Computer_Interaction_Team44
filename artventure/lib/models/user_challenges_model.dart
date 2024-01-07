import 'dart:convert';

UserChallenges userChallengesFromMap(String str) =>
    UserChallenges.fromMap(json.decode(str));

String userChallengesToMap(UserChallenges data) => json.encode(data.toMap());

class UserChallenges {
  final int? id;
  final int challengeId;
  final int userId;
  final String status;

  UserChallenges({
    this.id,
    required this.challengeId,
    required this.userId,
    required this.status,
  });

  factory UserChallenges.fromMap(Map<String, dynamic> json) => UserChallenges(
        id: json["id"],
        challengeId: json["challengeId"],
        userId: json["userId"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "challengeId": challengeId,
        "userId": userId,
        "status": status,
      };
}
