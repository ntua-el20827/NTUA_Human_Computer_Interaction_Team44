import 'package:artventure/database/database_helper.dart';
import 'package:artventure/models/challenges_model.dart';
import 'package:artventure/models/events_model.dart';

Future<void> insertData() async {
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
  //Theater
  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Theater Challenge 1',
    points: 150,
    category: 'Theater',
    infoText:
        'Create a short monologue and perform it in front of a small audience.',
    imageFilePath: 'challenges/theater.jpg',
  ));

  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Theater Challenge 2',
    points: 120,
    category: 'Theater',
    infoText:
        'Design and create a set for a fictional play. Showcase your creativity!',
    imageFilePath: 'challenges/theater.jpg',
  ));

  //Music
  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Music Challenge 1',
    points: 100,
    category: 'Music',
    infoText:
        'Compose a short melody using only four musical notes. Share your creation!',
    imageFilePath: 'challenges/music.jpg',
  ));

  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Music Challenge 2',
    points: 80,
    category: 'Music',
    infoText:
        'Record a cover of your favorite song and add your unique twist to it.',
    imageFilePath: 'challenges/music_challenge2.jpg',
  ));

  // VisualArts
  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Visual Arts Challenge 1',
    points: 180,
    category: 'VisualArts',
    infoText:
        'Create a digital artwork inspired by a famous painting. Share your interpretation!',
    imageFilePath: 'challenges/visual_arts_challenge1.jpg',
  ));

  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Visual Arts Challenge 2',
    points: 200,
    category: 'VisualArts',
    infoText:
        'Sculpt a miniature model using unconventional materials. Let your imagination run wild!',
    imageFilePath: 'challenges/visual_arts_challenge2.jpg',
  ));

  // Dance
  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Dance Challenge 1',
    points: 140,
    category: 'Dance',
    infoText:
        'Choreograph a dance routine to a popular song. Record and share your performance!',
    imageFilePath: 'challenges/dance_challenge1.jpg',
  ));

  await DatabaseHelper().insertChallenge(Challenge(
    title: 'Dance Challenge 2',
    points: 160,
    category: 'Dance',
    infoText:
        'Learn and perform a dance style you have ve never tried before. Embrace the challenge!',
    imageFilePath: 'challenges/dance_challenge2.jpg',
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
  await DatabaseHelper().insertEvent(Events(
    title: 'Event 2',
    category: 'Music',
    location: 'Papanikolaou 2 Zografou Greece',
    infoText: 'Piano Seminar for Beginners ',
    eventCreator: 'TheGrantPiano',
    eventImageFilePath: 'challenges/music.jpg',
  ));
  await DatabaseHelper().insertEvent(Events(
    title: 'Art Exhibition',
    category: 'VisualArts',
    location: 'Galinis 9, 157 72 Zografos, Greece',
    infoText:
        'Explore a diverse collection of contemporary art pieces at our Art Exhibition.',
    eventCreator: 'ArtCurator123',
    eventImageFilePath: 'challenges/visual_arts.jpg',
  ));

  await DatabaseHelper().insertEvent(Events(
    title: 'Dance Workshop',
    category: 'Dance',
    location: 'Eleftheriou Venizelou 37, 157 73 Zografos, Greece',
    infoText:
        'Join us for an energetic and fun dance workshop suitable for all levels of experience.',
    eventCreator: 'DancePassion',
    eventImageFilePath: 'challenges/dance.jpg',
  ));

  /// Get the locations from: https://gps-coordinates.org/
}
