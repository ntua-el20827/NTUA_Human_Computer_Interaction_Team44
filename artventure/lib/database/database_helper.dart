import 'dart:io';

import 'package:flutter/material.dart';
import 'package:artventure/models/challenges_model.dart';
import 'package:artventure/models/event_creators_model.dart';
import 'package:artventure/models/user_challenges_model.dart';
import 'package:artventure/models/user_info_model.dart';
import 'package:artventure/models/events_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:device_info/device_info.dart';
//import 'package:path_provider/path_provider.dart';

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
  // Comment: Both userId and username are unique
  // userId is used as foreign key in the next tables

  // UserInfo table
  String userInfo = '''
   CREATE TABLE user_info (
      userId INTEGER PRIMARY KEY,
      favoriteArt TEXT,
      artTaste TEXT,
      -- add other fields as needed
      FOREIGN KEY (userId) REFERENCES users(userId)
   )
''';

/*
  String userInfo = '''
   CREATE TABLE user_info (
      userId INTEGER PRIMARY KEY,
      favoriteArt TEXT,
      favoriteArtist TEXT
      -- add other fields as needed
   )
''';
*/

  // Challenges table
  String challenges = ''';
   CREATE TABLE challenges (
     challengeId INTEGER PRIMARY KEY AUTOINCREMENT,
     title TEXT,
     points INTEGER,
     category TEXT,
     infoText TEXT,
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
     eventCreator TEXT,
     eventImageFilePath TEXT
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
  /*String eventImages = '''
   CREATE TABLE event_images (
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     eventId INTEGER,
     imagePath TEXT,
     FOREIGN KEY (eventId) REFERENCES events(eventId)
   )
   ''';*/

  Future<bool> databaseExists(String path) async {
    return await File(path).exists();
  }

  // Our connection is ready
  Future<Database> initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, databaseName);
    //final databasePath = await getDatabasesPath(); // for george
    //final path = join(databasePath, databaseName); // for geroge
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(userInfo);
      await db.execute(challenges);
      await db.execute(userChallenges);
      await db.execute(events);
      await db.execute(eventCreators);
      await db.execute(userLikes);
      //await db.execute(eventImages);
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

  Future<bool> authenticate_ec(String username, String password) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
      "SELECT * FROM event_creators WHERE username = ? AND password = ?",
      [username, password],
    );
    return result.isNotEmpty;
  }

  // Sign up
  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    int userId = await db.insert("users", usr.toMap());
    return userId;
  }

  Future<void> saveUserAnswers(UserInfo userInfo) async {
    final Database db = await initDB();
    await db.insert(
      'user_info',
      userInfo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Function to insert a new event creator into the database
  Future<int> createEventCreator(EventCreator eventCreator) async {
    final Database db = await initDB();
    return db.insert("event_creators", eventCreator.toMap());
  }

  Future<int> createEvent(Events event) async {
    final Database db = await initDB();
    return db.insert("events", event.toMap());
  }

  Future<EventCreator?> getEventCreator(String username) async {
    final Database db = await initDB();
    var res = await db
        .query("event_creators", where: "username = ?", whereArgs: [username]);
    if (res.isNotEmpty) {
      return EventCreator.fromMap(res.first);
    } else {
      return null;
    }
  }

  // Get current User details
  Future<Users?> getUser(String username) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<UserInfo?> getUserInfo(int userId) async {
    final Database db = await initDB();
    var results = await db.query(
      'user_info',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return results.isNotEmpty ? UserInfo.fromMap(results.first) : null;
  }

  Future<void> updateUserPoints(String username, int newPoints) async {
    final Database db = await initDB();
    await db.update(
      'users',
      {'points': newPoints},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  Future<int?> getUserId(String username) async {
    final Database db = await initDB();
    var res = await db.query("users",
        columns: ["userId"], where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? res.first["userId"] as int : null;
  }

  ///////////////////////// CHALLENGES
  // Get a challenge by its ID
  Future<Challenge?> getChallenge(int challengeId) async {
    final Database db = await initDB();
    var res = await db
        .query("challenges", where: "challengeId= ?", whereArgs: [challengeId]);
    return res.isNotEmpty ? Challenge.fromMap(res.first) : null;
  }

  Future<List<Challenge>> getAllChallenges() async {
    final Database db = await initDB();

    final List<Map<String, dynamic>> maps = await db.query('challenges');

    return List.generate(maps.length, (i) {
      return Challenge(
        challengeId: maps[i]['challengeId'],
        title: maps[i]['title'],
        points: maps[i]['points'],
        category: maps[i]['category'],
        infoText: maps[i]['infoText'],
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

///////////////////// USER CHALLENGES
// Function to get user challenges for a specific username
  Future<List<UserChallenges>> getUserChallenges(String? username) async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'user_challenges',
      where: 'userId = (SELECT userId FROM users WHERE username = ?)',
      whereArgs: [username],
    );

    return List.generate(maps.length, (i) {
      return UserChallenges(
        id: maps[i]['id'],
        challengeId: maps[i]['challengeId'],
        userId: maps[i]['userId'],
        status: maps[i]['status'],
      );
    });
  }

  Future<int> insertUserChallenge(UserChallenges userChallenge) async {
    final Database db = await initDB();
    return await db.insert('user_challenges', userChallenge.toMap());
  }

  Future<void> changeChallengeStatus(int? challengeId, String newStatus) async {
    final Database db = await initDB();
    await db.update(
      'user_challenges',
      {'status': newStatus},
      where: 'challengeId = ?',
      whereArgs: [challengeId],
    );
  }

  Future<void> removeChallengeFromUserChallenge(int? challengeId) async {
    final Database db = await initDB();
    await db.delete(
      'user_challenges',
      where: 'challengeId = ?',
      whereArgs: [challengeId],
    );
  }

  // Get events created by a specific event creator
  Future<List<Events>> getEventsByCreator(String creatorName) async {
    final Database db = await initDB();
  
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
     where: 'eventCreator = ?',
      whereArgs: [creatorName],
    );

    return List.generate(maps.length, (index) {
      return Events(
        eventId: maps[index]['eventId'],
        title: maps[index]['title'],
        category: maps[index]['category'],
        location: maps[index]['location'],
        infoText: maps[index]['infoText'],
        eventCreator: maps[index]['eventCreator'],
        eventImageFilePath: maps[index]['eventImageFilePath'],
      );
    });
  }
}
