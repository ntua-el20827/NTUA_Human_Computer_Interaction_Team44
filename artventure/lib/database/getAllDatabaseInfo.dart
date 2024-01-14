import 'package:artventure/database/database_helper.dart';
import 'package:artventure/models/challenges_model.dart';
import 'package:artventure/models/events_model.dart';

Future<void> getAllDatabaseInfo() async {
  // This is the main functions that fills the database of the device with the updated file
  // In order to work it requires a server that stores this data and an API that request this data
  // This is not in the context of the class, so for the demo-version we will insert dummy data!
  // This insertion happens whenever the user reopens his app!

  // API call and Proper Download of data

  // Insertion of Dummy Data for Demo Versio:
  await insertDummyData();
}

Future<void> insertDummyData() async {
  // Insert Dummy Challenges
  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Challenge 1',
    points: 10,
    category: 'Category 1',
    infoText: 'Info about Challenge 1',
    imageFilePath: 'challenges/theater.jpg',
  ));

  // Insert Dummy Events
  await DatabaseHelper().insertEvent(Events(
    title: 'Event 1',
    category: 'Theater',
    location: 'Dimocratias 7 Zografou Greece',
    infoText: 'Info about Event 1',
    eventCreator: 'Creator 1',
    eventImageFilePath: 'challenges/theater.jpg',
  ));
}




    // String address2 = 'Papanikolaou 2 Zografou Greece';
    // String locationString2 = await getLatLong(address2);
    // print("ADDRESS");
    // print(locationString2);
    // if (locationString2.isNotEmpty) {
    //   Events dummyEvent2 = Events(
    //     title: 'Dummy Event2',
    //     category: 'Theater',
    //     location: '$locationString2',
    //     infoText: 'This is a dummy event for testing.',
    //     eventCreator: 'Test User2',
    //     eventImageFilePath: '/challenges/theater.jpg',
    //   );