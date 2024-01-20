import 'dart:async';
import 'package:artventure/components/appbar.dart';
import 'package:artventure/components/bottom_navigation_bar.dart';
import 'package:artventure/database/database_helper.dart';
import 'package:artventure/models/events_model.dart';
import 'package:artventure/pages/event_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

// Explore Page2 because Explore Page was a disaster :)

class ExplorePage2 extends StatefulWidget {
  final String? username;
  const ExplorePage2({Key? key, this.username}) : super(key: key);

  @override
  _ExplorePageState2 createState() => _ExplorePageState2();
}

class _ExplorePageState2 extends State<ExplorePage2> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.974966, 23.770003),
    zoom: 12.6, // showing Zografou!
  );

  final List<Marker> _markers = <Marker>[]; // Each event is a different marker!

  @override
  void initState() {
    super.initState();
    //getAllDatabaseInfo();
    //_deleteAllEvents(); // Χρησιμοποιείται μόνο στο testing οπου δεν δουλεύει η βάση σωστά!
    //_addDummyEvents(); // Οταν δουλέψει η βάση καη η εισαγωγή δεδομένων, θα πρέπει να φύγει
    _loadEvents();
  }

// When Database didn't actually work
  Future<void> _deleteAllEvents() async {
    await DatabaseHelper().deleteAllEvents();
  }

  Future<void> _addDummyEvents() async {
    // These dummy events are used in the insertDummyEvents() function in the insertData.dart
    String address = 'Dimocratias 7 Zografou Greece';
    String locationString = await getLatLong2(address);
    print("ADDRESS");
    print(locationString);
    if (locationString.isNotEmpty) {
      Events dummyEvent = Events(
        title: 'Dummy Event1',
        category: 'Music',
        location: '$locationString',
        infoText: 'This is a dummy event for testing.',
        eventCreator: 'Test User2',
        eventImageFilePath: '/challenges/theater.jpg',
      );

      await DatabaseHelper().createEvent(dummyEvent);
    } else {
      print('Unable to fetch coordinates for the provided address.');
    }
    String address2 = 'Papanikolaou 2 Zografou Greece';
    String locationString2 = await getLatLong2(address2);
    print("ADDRESS");
    print(locationString2);
    if (locationString2.isNotEmpty) {
      Events dummyEvent2 = Events(
        title: 'Dummy Event2',
        category: 'Theater',
        location: '$locationString2',
        infoText: 'This is a dummy event for testing.',
        eventCreator: 'Test User2',
        eventImageFilePath: '/challenges/theater.jpg',
      );

      await DatabaseHelper().createEvent(dummyEvent2);
    } else {
      print('Unable to fetch coordinates for the provided address.');
    }
    _loadEvents();
  }

  // Main Functions!!
  Future<void> _loadEvents() async {
    List<Events> events = await DatabaseHelper().getAllEvents();
    setState(() {
      _markers.clear(); // Clear existing markers
      print("Hello! from loadEvents");
      _markers.addAll(_createMarkers(events));
    });
  }

  Future<String> getLatLong2(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;

        return '$latitude-$longitude';
      } else {
        return ''; // Return an empty string or handle the case when no location is found.
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
      return ''; // Handle errors, return an empty string, or throw an exception as needed.
    }
  }

  Set<Marker> _createMarkers(List<Events> events) {
    return events.map((event) {
      //String latlongLocation = await getLatLong(event.location);
      List<String> locationParts = event.latlonglocation!.split('-');
      double latitude = double.parse(locationParts[0]);
      double longitude = double.parse(locationParts[1]);
      print("LATITUDE");
      print(latitude);
      print("LONGTITUDE");
      print(longitude);

      BitmapDescriptor markerIcon;
      // Assign different colors based on the category
      switch (event.category) {
        case 'Theater':
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
          break;
        case 'Music':
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
          break;
        case 'Dance':
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
          break;
        case 'VisualArts':
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
          break;
        default:
          markerIcon =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
          break;
      }

      return Marker(
        markerId: MarkerId(event.eventId.toString()),
        position: LatLng(latitude, longitude),
        icon: markerIcon,
        infoWindow: InfoWindow(
          title: event.title,
          snippet: event.category,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventPage(event: event),
              ),
            );
          },
        ),
      );
    }).toSet();
  }

  /// getUserCurrentLocation
  /// https://www.geeksforgeeks.org/how-to-get-users-current-location-on-google-maps-in-flutter/
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          // 3 children-> Container (Map and Markers) / Positioned (Categories Hover boxes) / Positioned (Hello message)
          Container(
            child: SafeArea(
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                markers: Set<Marker>.of(_markers),
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: HoverBox(
                text:
                    'Hello, ${widget.username}! Explore our Events!\nClick on a event to learn more about it!',
                color: const Color.fromARGB(255, 112, 23, 125),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Column(
              children: [
                HoverBox(
                  text: 'Theater',
                  color: Colors.red,
                ),
                SizedBox(width: 16.0),
                HoverBox(
                  text: 'Music',
                  color: Colors.orange,
                ),
                SizedBox(width: 16.0),
                HoverBox(
                  text: 'Dance',
                  color: Colors.cyan,
                ),
                SizedBox(width: 16.0),
                HoverBox(
                  text: 'VisualArts',
                  color: Colors.green,
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());

            _markers.add(
              Marker(
                markerId: MarkerId("0"),
                position: LatLng(value.latitude, value.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              ),
            );

            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.my_location_rounded),
      ),
      bottomNavigationBar: BottomNavBar(
        username: widget.username,
        currentIndex: 2,
      ),
    );
  }
}

class HoverBox extends StatelessWidget {
  final String text;
  final Color color;

  const HoverBox({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }
}
