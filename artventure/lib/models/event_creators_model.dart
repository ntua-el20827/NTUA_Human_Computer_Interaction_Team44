import 'dart:convert';

EventCreators eventCreatorsFromMap(String str) =>
    EventCreators.fromMap(json.decode(str));

String eventCreatorsToMap(EventCreators data) => json.encode(data.toMap());

class EventCreators {
  final int? id;
  final String name;

  EventCreators({
    this.id,
    required this.name,
  });

  factory EventCreators.fromMap(Map<String, dynamic> json) => EventCreators(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
