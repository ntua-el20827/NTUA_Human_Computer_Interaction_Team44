import 'package:sqflite/sqflite.dart';
import 'package:artventure/database/database_service.dart';
import 'package:artventure/models/challenge_model.dart';
import 'package:artventure/models/user_model.dart';

class ArtventureDB {
  final user_table_name = 'users';
  final challenge_table_name = 'challenges';

  Future<void> createTables(Database database) async {
    await database.execute('''
            CREATE TABLE IF NOT EXISTS $user_table_name(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              username TEXT,
              password TEXT,
              favoriteArt TEXT,
              age INTEGER,
              points INTEGER
            )
          ''');
    database.execute('''
            CREATE TABLE IF NOT EXISTS $challenge_table_name(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              infoText TEXT,
              points INTEGER,
              imageUrl TEXT,
              state TEXT
            )
          ''');
  }

  // To insert data we have to create a function called "create"

  // Inside ArtventureDB class

  Future<int> insertUser(User user) async {
    final db = await DatabaseService().getDatabase();
    return await db.insert(user_table_name, user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await DatabaseService().getDatabase();
    return await db.update(
      user_table_name,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<User>> getUsers() async {
    final db = await DatabaseService().getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(user_table_name);
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        favoriteArt: maps[i]['favoriteArt'],
        age: maps[i]['age'],
        points: maps[i]['points'],
      );
    });
  }

  Future<int> insertChallenge(Challenge challenge) async {
    final db = await DatabaseService().getDatabase();
    return await db.insert(challenge_table_name, challenge.toMap());
  }

  Future<int> updateChallenge(Challenge challenge) async {
    final db = await DatabaseService().getDatabase();
    return await db.update(
      challenge_table_name,
      challenge.toMap(),
      where: 'id = ?',
      whereArgs: [challenge.id],
    );
  }

  Future<List<Challenge>> getChallenges() async {
    final db = await DatabaseService().getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(challenge_table_name);
    return List.generate(maps.length, (i) {
      return Challenge(
          id: maps[i]['id'],
          name: maps[i]['name'],
          info: maps[i]['info'],
          points: maps[i]['points'],
          image: maps[i]['image'],
          state: maps[i]['state'],
          categories: maps[i]['categories']);
    });
  }
}
