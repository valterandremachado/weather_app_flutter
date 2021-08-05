import 'package:geolocator/geolocator.dart';

class Location {
  double lat = 0;
  double long = 0;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      print('location exception: $e');
    }
  }
}
