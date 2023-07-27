import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:easy_geofencing/easy_geofencing.dart';



class Geotagger{

  CameraPosition initialCameraPosition = const CameraPosition(target: LatLng(9.9252, 78.1198),zoom: 15.0);
  Set<Marker> markers = <Marker>{};
  Set<Circle> circles = <Circle>{};

  Geotagger();
  Future<void> geotagLocation() async {

   final Position position = await getCurrentPosition();
   final LatLng latLng = LatLng(position.latitude ,position.longitude);



final List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

String address = '';

if(placemarks.isNotEmpty){

  final Placemark placemark = placemarks.first;

  address = placemark.street??'';
  address += ', ${placemark.subLocality ?? ''}';
  address += ', ${placemark.locality ?? ''}';
  address += ', ${placemark.administrativeArea ?? ''}';
  address += ', ${placemark.country ?? ''}';
}

   initialCameraPosition = CameraPosition(
    target: latLng, 
    zoom:15.0,
  );

  final marker = Marker(
    markerId: const MarkerId('geotagged_location'),
    position:latLng,
    infoWindow: InfoWindow(title: address),
    );

    // final circle = Circle(
    //   circleId: CircleId('geofence_circle'),
    //   center: latLng,
    //   radius: 100, // radius in meters
    //   strokeWidth: 2,
    //   strokeColor: Colors.blue,
    //   fillColor: Colors.blue.withOpacity(0.2),
    // );
    
    markers.add(marker);
    // circles.add(circle);
    // await addGeofence(latLng);

  }

  // Future<void> addGeofence(LatLng latLng) async {
  //   GeofenceRegion region = GeofenceRegion(
  //     id: '1',
  //     latitude: latLng.latitude,
  //     longitude: latLng.longitude,
  //     radius: 100, // radius in meters
  //     trigger: GeofenceEvent.enter | GeofenceEvent.exit,
  //   );

  //   await Geofence.registerGeofence(region, (GeofenceEvent event) {
  //     if (event == GeofenceEvent.enter) {
  //       // Handle enter event
  //     } else if (event == GeofenceEvent.exit) {
  //       // Handle exit event
  //     }
  //   });
  // }
  // Future<void> addGeofence(LatLng latLng) async {
  //   final geofence = GeoFenceService();
  //   await geofence.addGeolocation(
  //     latitude: latLng.latitude,
  //     longitude: latLng.longitude,
  //     radius: 100, // radius in meters
  //     identifier: 'geofence1',
  //     androidSettings: GeofenceSettings(
  //       initialTriggers: [GeofenceEvent.enter, GeofenceEvent.exit],
  //       notificationTitle: 'Geofence',
  //       notificationContent: 'You entered or exited the geofenced area',
  //     ),
  //     iosSettings: GeofenceSettings(
  //       initialTriggers: [GeofenceEvent.enter, GeofenceEvent.exit],
  //       notificationTitle: 'Geofence',
  //       notificationContent: 'You entered or exited the geofenced area',
  //     ),
  //   );
  // }
  
  Future<Position> getCurrentPosition() async {

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }

}