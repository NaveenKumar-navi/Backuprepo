import 'package:attend/GeolocationHandler.dart';
import 'package:attend/PermissionHandler.dart';
import 'package:attend/component/Geotagger.dart';
import 'package:attend/controller/PunchController.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_action/slide_action.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/user.dart';
import '../model/token.dart';
import 'package:geocoding/geocoding.dart';
import 'package:attend/model/location_model.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
//import 'package:slide_to_act/slide_to_act.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<TodayScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  final PermissionHandler _permissionHandler = PermissionHandler();
  final GeolocationHandler _geolocationHandler = GeolocationHandler();
  Geotagger geotagger = Geotagger();
  late GoogleMapController mapController;
  String checkIn = "--/--";
  String checkOut = "--/--";
  bool isLoading = true;
  String location = " ";
  PunchController punchController = Get.put(PunchController());

  LinearGradient primary = const LinearGradient(
    colors: [Color(0xff574F8D), Color(0xffF24BA0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  //Color primary = const Color(0xffeef444c);

  @override
  void initState() {
    super.initState();
    _getPunchRecord();
  }

  Future<String> _getLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(LocationModel.lat, LocationModel.long);
    String location =
        "${placemarks[0].street},${placemarks[0].locality},${placemarks[0].administrativeArea},${placemarks[0].postalCode},${placemarks[0].country}";
    return location;
  }

  // void _getRecored() async {
  //   try {
  //     /*QueryShapshot shap = await FirebaseFirestore.instance
  //         .collection("Employee")
  //         .where('id', isEqualTo: User.username)
  //         .get();

  //     print(snap.docs[0].id);

  //     DocumentSnapshot snap2 = await FirebaseFirestore.instance
  //         .collection("Employee")
  //         .doc(snap.docs[0].id)
  //         .collection("Record")
  //         .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
  //         .get();

  //     setState(() {
  //       checkIn = snap2['checkIn'];
  //       checkOut = snap2['checkOut'];
  //     });*/
  //   } catch (e) {
  //     setState(() {
  //       checkIn = "--/--";
  //       checkOut = "--/--";
  //     });
  //   }
  // }

  void _getPunchRecord() async {
    try {
      final data = await punchController.fetchAttendanceDataByDate(
          DateFormat('yyyy-MM-dd').format(DateTime.now()));

      setState(() {
        checkIn = data.checkIn != null && data.checkIn.isNotEmpty
            ? data.checkIn
            : checkIn;
        checkOut = data.checkOut != null && data.checkOut.isNotEmpty
            ? data.checkOut
            : checkOut;
      });
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "WelCome",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "NexaRegular",
                    fontSize: screenWidth / 20,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  Users.username,
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  "Today's Status",
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 32),
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Check In",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            checkIn,
                            style: TextStyle(
                              fontFamily: "NexaBold",
                              fontSize: screenWidth / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Check Out",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            checkOut,
                            style: TextStyle(
                              fontFamily: "NexaBold",
                              fontSize: screenWidth / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: screenWidth / 18,
                        fontFamily: "NexaBold",
                      ),
                      children: [
                        TextSpan(
                            text:
                                DateFormat(' MMMM yyyy').format(DateTime.now()),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth / 20,
                              fontFamily: "NexaBold",
                            ))
                      ]),
                ),
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat('hh:mm:ss a').format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }),
              checkOut == "--/-"
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: Builder(
                            builder: (context) {
                              //final GlobalKey<SlideActionState> key =
                                  //GlobalKey();
                              return SlideAction(
                               trackBuilder: (context, state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        checkIn == "--/--"
                                    ? "Slide to Check In"
                                    : "Slide to Check In",
                                      ),
                                    ),
                                  );
                                },
                                thumbBuilder: (context, state) {
                                  return Container(
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient:primary
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                action: () async {
                                  location = await _getLocation();
                                  final bool permissionGranted =
                                      await _permissionHandler
                                          .requestLocationPermission();
                                  if (permissionGranted) {
                                    await geotagger.geotagLocation();
                                    final LatLng latLng =
                                        geotagger.initialCameraPosition.target;
                                    setState(() {
                                      mapController.animateCamera(
                                          CameraUpdate.newLatLng(latLng));
                                    });
                                    final Position position =
                                        await _geolocationHandler
                                            .getCurrentPosition();
                                    debugPrint(
                                        "Latitude: ${position.latitude}");
                                    debugPrint(
                                        "Longitude: ${position.longitude}");
                                    try {
                                      String inn = "";
                                      String out = "";
                                      String checkInLoc = "";
                                      String checkOutLoc = "";
                                      if (checkIn == "--/--") {
                                        inn = DateFormat('hh:mm a')
                                            .format(DateTime.now());
                                        checkInLoc = location;
                                      } else {
                                        out = DateFormat('hh:mm a')
                                            .format(DateTime.now());
                                        checkOutLoc = location;
                                      }
                                      final data = await punchController
                                          .fetchAttendanceData(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()),
                                              inn,
                                              out,
                                              checkInLoc,
                                              checkOutLoc);
                                      setState(() {
                                        checkIn = data.checkIn != null &&
                                                data.checkIn.isNotEmpty
                                            ? data.checkIn
                                            : checkIn;
                                        checkOut = data.checkOut != null &&
                                                data.checkOut.isNotEmpty
                                            ? data.checkOut
                                            : checkOut;
                                      });
                                    } catch (e) {
                                      setState(() {
                                        checkIn = "--/--";
                                        checkOut = "--/--";
                                      });
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Permission Required'),
                                          content:
                                              Text('Turn on Location'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                // Code to be executed when the OK button is pressed.
                                                Navigator.of(context)
                                                    .pop(); // Close the alert dialog.
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height:
                              16, // Adjust the height as needed to add space between the slide bar and the map
                        ),
                        SizedBox(
                          height: 300, // Adjust the height as needed
                          child: GoogleMap(
                            initialCameraPosition:
                                geotagger.initialCameraPosition,
                            markers: geotagger.markers,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          child: Builder(
                            builder: (context) {
                              //final GlobalKey<SlideActionState> key = GlobalKey();
                              return SlideAction(
                                trackBuilder: (context, state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        checkIn == "--/--"
                                    ? "Slide to Check In"
                                    : "Slide to Check Out",
                                      ),
                                    ),
                                  );
                                },
                                thumbBuilder: (context, state) {
                                  return Container(
                                    margin: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient:primary
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                action: () async {
                                  final bool permissionGranted =
                                      await _permissionHandler
                                          .requestLocationPermission();
                                  if (permissionGranted) {
                                    await geotagger.geotagLocation();
                                    final LatLng latLng =
                                        geotagger.initialCameraPosition.target;
                                    setState(() {
                                      mapController.animateCamera(
                                          CameraUpdate.newLatLng(latLng));
                                    });
                                    final Position position =
                                        await _geolocationHandler
                                            .getCurrentPosition();
                                    debugPrint(
                                        "Latitude: ${position.latitude}");
                                    debugPrint(
                                        "Longitude: ${position.longitude}");

                                    try {
                                      String inn = "";
                                      String out = "";
                                      String checkInLoc = "";
                                      String checkOutLoc = "";
                                      if (checkIn == "--/--") {
                                        inn = DateFormat('hh:mm a')
                                            .format(DateTime.now());
                                        checkInLoc = location;
                                      } else {
                                        out = DateFormat('hh:mm a')
                                            .format(DateTime.now());
                                        checkOutLoc = location;
                                      }
                                      final data = await punchController
                                          .fetchAttendanceData(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()),
                                              inn,
                                              out,
                                              checkInLoc,
                                              checkOutLoc);
                                      setState(() {
                                        checkIn = data.checkIn != null &&
                                                data.checkIn.isNotEmpty
                                            ? data.checkIn
                                            : checkIn;
                                        checkOut = data.checkOut != null &&
                                                data.checkOut.isNotEmpty
                                            ? data.checkOut
                                            : checkOut;
                                      });
                                    } catch (e) {
                                      setState(() {
                                        checkIn = "--/--";
                                        checkOut = "--/--";
                                      });
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Permission Required'),
                                          content:
                                              Text('Turn on Location'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                // Code to be executed when the OK button is pressed.
                                                Navigator.of(context)
                                                    .pop(); // Close the alert dialog.
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height:
                              16, // Adjust the height as needed to add space between the slide bar and the map
                        ),
                        SizedBox(
                          height: 300, // Adjust the height as needed
                          child: GoogleMap(
                            initialCameraPosition:
                                geotagger.initialCameraPosition,
                            markers: geotagger.markers,
                            onMapCreated: (controller) {
                              setState(() {
                                // ignore: unnecessary_null_comparison
                                mapController = controller;
                              });
                            },
                          ),
                        ),
                      ],
                    )
              // Container(
              //   margin: const EdgeInsets.only(top: 32),
              //   child: Text(
              //       "You have completed this day!",
              //     style: TextStyle(
              //       fontFamily: "NexaRegular",
              //       fontSize: screenWidth / 20,
              //       color: Colors.black54,
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
