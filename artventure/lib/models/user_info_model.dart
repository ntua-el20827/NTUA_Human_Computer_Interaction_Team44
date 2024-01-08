import 'dart:convert';

UserInfo userInfoFromMap(String str) => UserInfo.fromMap(json.decode(str));

String userInfoToMap(UserInfo data) => json.encode(data.toMap());

class UserInfo {
  final int userId;
  final String? favoriteArt;
  final String? favoriteArtist;
  // add other fields as needed

  UserInfo({
    required this.userId,
    this.favoriteArt,
    this.favoriteArtist,
    // add other fields as needed
  });

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        userId: json["userId"],
        favoriteArt: json["favoriteArt"],
        favoriteArtist: json["favoriteArtist"],
        // add other fields as needed
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "favoriteArt": favoriteArt,
        "favoriteArtist": favoriteArtist,
        // add other fields as needed
      };
}
