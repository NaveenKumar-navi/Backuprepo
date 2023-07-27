// import 'package:flutter/cupertino.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:image_picker/image_picker.dart';

// class FaceDetectionWidget extends StatefulWidget{
//    @override
//   _FaceDetectionWidgetState createState() => _FaceDetectionWidgetState();
// }

// class _FaceDetectionWidgetState extends State<FaceDetectionWidget>{

// FaceDetector detector;


// void initState(){

//   super.initState();
//   _initializeDetector();
// }

// void _initializeDetector() async {

//   detector = await FaceDetector.create();
//   detector.setMode(FaceDetectorMode.accurate);
// }

// void dispose(){
//   detector.close();
//   super.dispose();
// }

// @override
// Widget build (BuildContext context){
//   _startFaceDetection();
//   return 
// }

// void _startFaceDetection() async {

// final imagePicker = ImagePicker();
// final pickedImage = await imagePicker.getImage(source :ImageSource.camera);

// if (pickedImage != null) {
//     final imageFile = File(pickedImage.path);

//     final inputImage = InputImage.fromFilePath(imageFile.path);

//     final faceDetector = GoogleMlKitFaceDetection.faceDetector();
//     final List<Face> faces = await faceDetector.processImage(inputImage);

//     // Process the detected faces
//     // ...

//     // Example: Print the number of faces detected
//     print('Number of faces detected: ${faces.length}');

//     // Clean up the face detector
//     faceDetector.close();
//   }
// }
// }