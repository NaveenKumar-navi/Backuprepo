import 'package:geolocator/geolocator.dart';
class GeolocationHandler{


  Future<Position> getCurrentPosition() async {

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    return position;
  }
}