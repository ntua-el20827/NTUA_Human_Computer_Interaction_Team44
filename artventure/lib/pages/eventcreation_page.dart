import 'dart:io';

import 'package:artventure/pages/event_page.dart';
import 'package:artventure/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/events_model.dart';
import 'package:artventure/components/event_card.dart';
import 'package:artventure/pages/login_page.dart';
import 'package:artventure/models/event_creators_model.dart';
import '../database/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:image_picker/image_picker.dart';


class EventCreationPage extends StatefulWidget {
  final String
      username; // Add a username parameter to the EventCreationPage constructor

  EventCreationPage({required this.username});

  @override
  _EventCreationPageState createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController bookingLinkController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  //TextEditingController eventImageFilePathController = TextEditingController();
  final db = DatabaseHelper();
  List<String> categoryOptions = ['Theater', 'Music', 'Dance', 'Visual Arts'];
  String selectedCategory = 'Theater';
  registerevent() async {
    final dbHelper = DatabaseHelper();
    final database = await dbHelper.initDB();
    String infoTextController =
                      "Duration: ${durationController.text}\nDescription: ${descriptionController.text}\nRating: ${ratingController.text}\nBooking Link: ${bookingLinkController.text}";
    var res = await db.createEvent(Events(
        title: titleController.text,
        category: categoryController.text,
        location: streetController.text,
        infoText: infoTextController,
        eventCreator: widget.username,
        eventImageFilePath: imageFilePath,
        )
      );
    if (res > 0) {
      EventCreator? eventCreatorDetails = await db.getEventCreator(widget.username);
      if (!mounted) return;
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage(profile: eventCreatorDetails)),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    descriptionController.dispose();
    streetController.dispose();
    ratingController.dispose();
    bookingLinkController.dispose();
    categoryController.dispose();
    super.dispose();
  }
  String imageFilePath = '';
  Future<void> chooseAndCaptureImage(BuildContext context) async {
    final picker = ImagePicker();

    showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: const Text('Select the source to pick the image from.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Camera'),
              onPressed: () async {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text('Gallery'),
              onPressed: () async {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    ).then((ImageSource? source) async {
      if (source != null) {
        final pickedFile = await picker.pickImage(source: source);

        if (pickedFile != null) {
          setState(() {
            imageFilePath = pickedFile.path;
          });
        }
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Create Event'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              hint: "Insert Title",
              icon: Icons.title,
              controller: titleController,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
  decoration: InputDecoration(
    hintText: "Select Category",
    prefixIcon: Icon(Icons.category),
    //enabledBorder: OutlineInputBorder(
      //borderRadius: BorderRadius.circular(10.0),
      //borderSide: BorderSide(color: Colors.grey),
    //),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue),
    ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  ),
  value: selectedCategory,
  items: categoryOptions.map((String category) {
    return DropdownMenuItem<String>(
      value: category,
      child: Text(category),
    );
  }).toList(),
  onChanged: (String? newValue) {
    setState(() {
      selectedCategory = newValue!;
    });
  },
),
            const SizedBox(height: 16),
            InputField(
              hint: "Dates Available (dd/mm/year-dd/mm/year)",
              icon: Icons.calendar_today,
              controller: durationController,
            ),
            const SizedBox(height: 16),
            TextField(
  controller: descriptionController,
  maxLines: null, // Allows multiple lines
  keyboardType: TextInputType.multiline,
  decoration: InputDecoration(
    hintText: "Description",
    prefixIcon: Icon(Icons.description),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.blue),
    ),
    fillColor: Colors.grey,
    filled: true,
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  ),
),
            const SizedBox(height: 16),
            InputField(
              hint: "Insert Street",
              icon: Icons.location_on,
              controller: streetController,
            ),
            const SizedBox(height: 16),
            InputField(
              hint: "Insert Rating",
              icon: Icons.star,
              controller: ratingController,
            ),
            const SizedBox(height: 16),
            InputField(
              hint: "Insert Booking Link",
              icon: Icons.link,
              controller: bookingLinkController,
            ),
            const SizedBox(height: 16),
            Container(
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: imageFilePath.isNotEmpty
                  ? Image.file(
                      File(imageFilePath),
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          chooseAndCaptureImage(context);
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Button(
              label: "Create Event",
              press: () {
                registerevent();
                // Save the new event to the database or perform any other necessary operations
                // DatabaseHelper.saveEvent(newEvent);

                // Clear the text fields
                /*titleController.clear();
                categoryController.clear();
                durationController.clear();
                descriptionController.clear();
                streetController.clear();
                ratingController.clear();
                bookingLinkController.clear();*/
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}
