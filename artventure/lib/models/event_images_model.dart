import 'dart:convert';

EventImage eventImageFromMap(String str) =>
    EventImage.fromMap(json.decode(str));

String eventImageToMap(EventImage data) => json.encode(data.toMap());

class EventImage {
  final int? id;
  final int eventId;
  final String imagePath;

  EventImage({
    this.id,
    required this.eventId,
    required this.imagePath,
  });

  factory EventImage.fromMap(Map<String, dynamic> json) => EventImage(
        id: json["id"],
        eventId: json["eventId"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "eventId": eventId,
        "imagePath": imagePath,
      };
}
