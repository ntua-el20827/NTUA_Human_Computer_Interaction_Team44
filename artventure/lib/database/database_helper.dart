import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DatabaseHelper {
  final databaseName = "artventure.db";

  // Tables

  // Users table
  String user = '''
   CREATE TABLE users (
     userId INTEGER PRIMARY KEY AUTOINCREMENT,
     username TEXT UNIQUE,
     password TEXT,
     favoriteArt TEXT,
     points INTEGER
   )
   ''';

  // Challenges table
  String challenges = '''
   CREATE TABLE challenges (
     challengeId INTEGER PRIMARY KEY AUTOINCREMENT,
     title TEXT,
     points INTEGER,
     category TEXT
   )
   ''';

  // UserChallenges table
  String userChallenges = '''
   CREATE TABLE user_challenges (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     challengeId INTEGER,
     userId INTEGER,
     status TEXT,
     FOREIGN KEY (challengeId) REFERENCES challenges(challengeId),
     FOREIGN KEY (userId) REFERENCES users(userId)
   )
   ''';

  // Events table
  String events = '''
   CREATE TABLE events (
     eventId INTEGER PRIMARY KEY AUTOINCREMENT,
     title TEXT,
     category TEXT,
     location TEXT,
     infoText TEXT,
     eventCreator TEXT
   )
   ''';

  // EventCreators table
  String eventCreators = '''
   CREATE TABLE event_creators (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name TEXT
   )
   ''';

  // UserLikes table
  String userLikes = '''
   CREATE TABLE user_likes (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     eventId INTEGER,
     userId INTEGER,
     FOREIGN KEY (eventId) REFERENCES events(eventId),
     FOREIGN KEY (userId) REFERENCES users(userId)
   )
   ''';

  // Our connection is ready
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(challenges);
      await db.execute(userChallenges);
      await db.execute(events);
      await db.execute(eventCreators);
      await db.execute(userLikes);
    });
  }

  // Function methods

  // Authentication
  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE username = ? AND password = ?",
      [usr.username, usr.password],
    );
    return result.isNotEmpty;
  }

  // Sign up
  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    return db.insert("users", usr.toMap());
  }

  // Get current User details
  Future<Users?> getUser(String username) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }
}
