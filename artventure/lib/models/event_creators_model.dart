import 'dart:convert';

EventCreator eventCreatorFromMap(String str) =>
    EventCreator.fromMap(json.decode(str));

String eventCreatorToMap(EventCreator data) => json.encode(data.toMap());

class EventCreator {
  final int? eventCreatorId;
  final String username;
  final String password;
  final String email;
  final String fullName;
  final int points;

  EventCreator({
    this.eventCreatorId,
    required this.username,
    required this.password,
    required this.email,
    required this.fullName,
    this.points = 0,
  });

  // Convert an EventCreator object into a Map
  Map<String, dynamic> toMap() {
    return {
      'eventCreatorid': eventCreatorId,
      'username': username,
      'password': password,
      'email': email,
      'fullName': fullName,
    };
  }

  // Create an EventCreator object from a Map
  factory EventCreator.fromMap(Map<String, dynamic> map) {
    return EventCreator(
      eventCreatorId: map['eventCreatorId'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      fullName: map['fullName'],
    );
  }

  // Copy method to create a new EventCreator object with some changes
  EventCreator copyWith({
    int? eventCreatorId,
    String? username,
    String? password,
    String? email,
    String? fullName,
  }) {
    return EventCreator(
      eventCreatorId: eventCreatorId ?? this.eventCreatorId,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
    );
  }
}