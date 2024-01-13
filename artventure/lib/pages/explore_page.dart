import 'package:artventure/components/appbar.dart';
import 'package:artventure/components/bottom_navigation_bar.dart';
import 'package:artventure/pages/event_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:artventure/database/database_helper.dart'; // Replace with your actual database helper import
import 'package:artventure/models/events_model.dart'; // Assuming this is your event model
import 'package:geolocator/geolocator.dart';

class ExplorePage extends StatefulWidget {
  final String? username;

  const ExplorePage({super.key, this.username});
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Parameters of this PageState
  // For markers:
  late GoogleMapController mapController;
  final DatabaseHelper dbHelper = DatabaseHelper();
  Set<Marker> markers = {};
  BitmapDescriptor? iconTheater;
  static const LatLng _initialPosition = const LatLng(37.978856, 23.783248);
  CameraPosition _initialCameraPosition = CameraPosition(target: _initialPosition,zoom: 13.0,);
  // For loading
  late Position currentPosition;
  bool dataLoaded = false;

  /// Initialization Of the Page
  // initState cannot be async
  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  // So i make one that can be!  
  Future<void> _initializeData() async {
  await _loadTheaterIcon();
  await _loadEvents();
  await _addDummyEvent();

  setState(() {
    dataLoaded = true;
    });
  }

  // Helpers!
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }
  

Future<void> _loadTheaterIcon() async {
    // Load the theater icon from the assets using BitmapDescriptor.fromAssetImage
    final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context);
    iconTheater = await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'assets/events/theater.png',
    );
  }

  _loadEvents() async {
    List<Events> events = await dbHelper.getAllEvents();
    print(currentPosition.latitude);
    print(currentPosition.longitude);
    setState(() {
      markers = _createMarkers(events);
      markers.add( Marker(
      markerId: MarkerId("user_location"),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: InfoWindow(title: "Your Location"),
    ),
    );
    });
  }

  _addDummyEvent() async {
    // Replace with your own logic to add a dummy event to the database
    Events dummyEvent = Events(
      title: 'Dummy Event',
      category: 'Art',
      location: '37.974155-23.764264', // Replace with actual coordinates
      infoText: 'This is a dummy event for testing.',
      eventCreator: 'Test User',
      eventImageFilePath: '/challenges/theater.jpg',
    );

    await dbHelper.createEvent(dummyEvent);
  }

Set<Marker> _createMarkers(List<Events> events) {
  return events
      .map((event) {
        // Split the location string into latitude and longitude
        List<String> locationParts = event.location.split('-');
        double latitude = double.parse(locationParts[0]);
        double longitude = double.parse(locationParts[1]);

        return Marker(
          markerId: MarkerId(event.eventId.toString()),
          position: LatLng(latitude, longitude),
          icon: iconTheater!,//?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
          infoWindow: InfoWindow(
            title: event.title,
            snippet: event.infoText,
          ),
        );
      })
      .toSet();
}

_onMarkerFunction(int eventId) {
  Future.delayed(Duration(milliseconds: 300), () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventPage(eventId: eventId),
      ),
    );
  });
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        markers: markers,
        
      ),
      bottomNavigationBar: BottomNavBar(username: widget.username),
    );
  }
}
