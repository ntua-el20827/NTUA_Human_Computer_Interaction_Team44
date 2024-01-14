import 'package:geocoding/geocoding.dart';

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
      return ''; // Return an empty string or handle the case when no location is found.
    }
  } catch (e) {
    print('Error fetching coordinates: $e');
    return ''; // Handle errors, return an empty string, or throw an exception as needed.
  }
}
