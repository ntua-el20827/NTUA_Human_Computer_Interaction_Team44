import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late GoogleMapController mapController;

  // Initial camera position (you can adjust these values)
  static const LatLng _initialPosition = const LatLng(37.7749, -122.4194);
  CameraPosition _initialCameraPosition = CameraPosition(
    target: _initialPosition,
    zoom: 13.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artventure - Demo - Explore'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: _initialCameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}
