import 'package:flutter/material.dart';
import 'package:artventure/components/button.dart';
import 'package:artventure/components/colors_and_fonts.dart';
import 'package:artventure/components/textfield.dart';
import 'package:artventure/models/events_model.dart';
import 'package:artventure/pages/login_page.dart';
import 'package:artventure/models/event_creators_model.dart';
import '../database/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class EventCreationPage extends StatefulWidget {
  final String username; // Add a username parameter to the EventCreationPage constructor

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
  TextEditingController bookingListController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    descriptionController.dispose();
    streetController.dispose();
    ratingController.dispose();
    bookingListController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    // Handle picture import logic here
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
              controller: bookingListController,
              decoration: InputDecoration(
                labelText: 'Insert Booking List',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create event logic here
                String title = titleController.text;
                String category = categoryController.text;
                String duration = durationController.text;
                String description = descriptionController.text;
                String street = streetController.text;
                String rating = ratingController.text;
                String bookingList = bookingListController.text;

                // Combine the duration, description, rating, and booking list into the infoText field
                String infoText =
                    "Duration: $duration\nDescription: $description\nRating: $rating\nBooking List: $bookingList";

                // Perform event creation with the entered data
                Events newEvent = Events(
                  title: title,
                  category: category,
                  location: street,
                  infoText: infoText,
                  eventCreator: widget.username, // Use the widget.username property to assign the creator's username
                );

                // Save the new event to the database or perform any other necessary operations
                // DatabaseHelper.saveEvent(newEvent);

                // Clear the text fields
                titleController.clear();
                categoryController.clear();
                durationController.clear();
                descriptionController.clear();
                streetController.clear();
                ratingController.clear();
                bookingListController.clear();
              },
              child: Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}