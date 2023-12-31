class User {
  final int id;
  final String username;
  final String password;
  final String favoriteArt;
  final int age;
  final int points;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.favoriteArt,
    required this.age,
    required this.points,
  });

  // Add any additional methods or constructors as needed
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'favoriteArt': favoriteArt,
      'age': age,
      'points': points,
    };
  }
}
