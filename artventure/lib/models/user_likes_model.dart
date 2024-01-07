import 'dart:convert';

UserLikes userLikesFromMap(String str) => UserLikes.fromMap(json.decode(str));

String userLikesToMap(UserLikes data) => json.encode(data.toMap());

class UserLikes {
  final int? id;
  final int eventId;
  final int userId;

  UserLikes({
    this.id,
    required this.eventId,
    required this.userId,
  });

  factory UserLikes.fromMap(Map<String, dynamic> json) => UserLikes(
        id: json["id"],
        eventId: json["eventId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "eventId": eventId,
        "userId": userId,
      };
}
