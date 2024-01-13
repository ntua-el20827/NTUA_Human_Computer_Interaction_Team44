import 'dart:convert';

UserInfo userInfoFromMap(String str) => UserInfo.fromMap(json.decode(str));

String userInfoToMap(UserInfo data) => json.encode(data.toMap());

class UserInfo {
  int userId;
  String? favoriteArt;
  String? favoriteArtist;
  // add other fields as needed

  UserInfo({
    required this.userId,
    this.favoriteArt,
    this.favoriteArtist,
    // add other fields as needed
  });

  
 // Convert a Users object into a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      "favoriteArt": favoriteArt,
      "favoriteArtist": favoriteArtist,
    };
  }

  // Create a Users object from a Map
  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      userId: map['userId'],
      favoriteArt: map["favoriteArt"],
      favoriteArtist: map["favoriteArtist"],
    );
  }
  // Add setters for favoriteArt, favoriteArtist, and userId
  set setFavoriteArt(String? value) {
    favoriteArt = value;
  }

  set setFavoriteArtist(String? value) {
    favoriteArtist = value;
  }

  set setUserId(int value) {
    userId = value;
  }
}