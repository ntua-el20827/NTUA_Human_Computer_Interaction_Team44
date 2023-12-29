import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // MyApp is a widget that is given as an argument
}

class MyApp extends StatelessWidget {
  // Object Oriented Programming like Java
  //
  const MyApp({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    // called every time we need to rebuild the UI
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 121, 36, 136),
            title: const Text("ArtVenture")),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("test"),
          ),
        ),
      ),
    );
    // Material App is used as the Root of the Application
    // Allows to control themes and routes
  }
}
