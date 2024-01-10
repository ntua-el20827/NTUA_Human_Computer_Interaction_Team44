import 'dart:io';

import 'package:artventure/models/challenges_model.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:device_info/device_info.dart';

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
      points INTEGER DEFAULT 0
   )
''';

  String userInfo = '''
   CREATE TABLE user_info (
      userId INTEGER PRIMARY KEY,
      favoriteArt TEXT,
      favoriteArtist TEXT,
      -- add other fields as needed
      FOREIGN KEY (userId) REFERENCES users(userId)
   )
''';

  // Challenges table
  String challenges = '''
   CREATE TABLE challenges (
     challengeId INTEGER PRIMARY KEY AUTOINCREMENT,
     title TEXT,
     points INTEGER,
     category TEXT,
     imageFilePath TEXT
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
     eventCreatorid INTEGER PRIMARY KEY AUTOINCREMENT,
     username TEXT UNIQUE,
     password TEXT,
     email TEXT,
     fullName TEXT
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

  // Event_Images table
  String eventImages = '''
   CREATE TABLE event_images (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     eventId INTEGER,
     imagePath TEXT,
     FOREIGN KEY (eventId) REFERENCES events(eventId)
   )
   ''';

  // Our connection is ready
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(userInfo);
      await db.execute(challenges);
      await db.execute(userChallenges);
      await db.execute(events);
      await db.execute(eventCreators);
      await db.execute(userLikes);
      await db.execute(eventImages);
    });
  }

  // Function methods
  // Sign up with device ID
  // Future<int> createUserWithDeviceId(Users usr) async {
  //   final Database db = await initDB();

  //   // Get device information
  //   String deviceId = await _getDeviceId();

  //   // Insert user data along with device ID
  //   usr.deviceId = deviceId;
  //   int userId = await db.insert("users", usr.toMap());

  //   return userId;
  // }

  // Get device ID
  Future<String> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = '';

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }
    } catch (e) {
      print('Error getting device ID: $e');
    }

    return deviceId;
  }

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

  // Function to insert a new event creator into the database
  Future<int> createEventCreator(EventCreator eventCreator) async {
    final Database db = await initDB();
    return db.insert("event_creators", eventCreator.toMap());
  }

  // Get current User details
  Future<Users?> getUser(String username) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  ///////////////////////// CHALLENGES
  Future<List<Challenge>> getAllChallenges() async {
    final Database db = await initDB();

    final List<Map<String, dynamic>> maps = await db.query('challenges');

    return List.generate(maps.length, (i) {
      return Challenge(
        challengeId: maps[i]['challengeId'],
        title: maps[i]['title'],
        points: maps[i]['points'],
        category: maps[i]['category'],
        imageFilePath: maps[i]['imageFilePath'],
      );
    });
  }

  // Function to insert a new challenge into the database
  Future<void> insertChallenge(Challenge challenge) async {
    final Database db = await initDB();
    await db.insert(
      'challenges',
      challenge.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
