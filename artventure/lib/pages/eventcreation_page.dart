import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/events_model.dart';
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
  TextEditingController eventImageFilePathController = TextEditingController();
  final db = DatabaseHelper();

  registerevent() async {
    final dbHelper = DatabaseHelper();
    final database = await dbHelper.initDB();
    String infoTextController =
                      "Duration: $durationController\nDescription: $descriptionController\nRating: $ratingController\nBooking List: $bookingLinkController";
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
      if (!mounted) return;
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()),
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
              Container(
                height: 200, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      chooseAndCaptureImage(context);// Handle picture import logic here
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Insert Title',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  labelText: 'Insert Category',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: durationController,
                decoration: InputDecoration(
                  labelText: 'Duration',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: streetController,
                decoration: InputDecoration(
                  labelText: 'Insert Street',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(
                  labelText: 'Insert Rating',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: bookingLinkController,
                decoration: InputDecoration(
                  labelText: 'Insert Booking Link',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  registerevent();
                  // Save the new event to the database or perform any other necessary operations
                  // DatabaseHelper.saveEvent(newEvent);
          
                  // Clear the text fields
                  titleController.clear();
                  categoryController.clear();
                  durationController.clear();
                  descriptionController.clear();
                  streetController.clear();
                  ratingController.clear();
                  bookingLinkController.clear();
                },
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
