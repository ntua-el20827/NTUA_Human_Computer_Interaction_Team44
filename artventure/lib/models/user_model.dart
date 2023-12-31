class User {
  final int id;
  final String username;
  final String password;
  final String favoriteArt;
  final int age;
  final int points;

  User({
    this.id = 0,
    required this.username,
    required this.password,
    this.favoriteArt = '',
    this.age = 18,
    this.points = 0,
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
