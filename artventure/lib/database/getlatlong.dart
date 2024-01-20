import 'package:geocoding/geocoding.dart';

// In order to show the events on the map we need to transform the address into latitude and longitude

Future<String> getLatLong(String address) async {
  try {
    print("address");
    print(address);
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      return '$latitude-$longitude';
    } else {
      return ''; // The empty string will be used as a checker
    }
  } catch (e) {
    print('Error fetching coordinates: $e');
    return '';
  }
}
