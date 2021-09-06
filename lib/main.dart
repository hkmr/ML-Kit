import 'package:mlkit/screens/barcode-reader/barcodeReader.dart';
import 'package:mlkit/screens/face-recognition/faceDetector.dart';
import 'package:mlkit/screens/object-detection/objectDetector.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


List<CameraDescription> cameras;

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(MaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(brightness: Brightness.light),
    home: _MyHomePage(),
    title: "Face Recognition",
    debugShowCheckedModeBanner: false,
  ));
}

class _MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {

  Widget _title(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Text(
        "machine learning \nkit".toUpperCase(),
        style: GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.bold,
          fontSize: 24.0
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Object detection
  Widget _objectDetection(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => new ObjectDetector(cameras: cameras)));
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/object_detection.png', fit: BoxFit.cover, height: 120,),
              Text('object detection'.toUpperCase(), style: TextStyle(),)
            ],
          ),
        ),
      ),
    );
  }

  // Text recognition
  Widget _textRecognition(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => new BarcodeReader()));
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/text_recognition.png', fit: BoxFit.cover, height: 120,),
              Text('text recognition'.toUpperCase(), style: TextStyle(),)
            ],
          ),
        ),
      ),
    );
  }

  // Face detection
  Widget _faceDetection(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => new FaceDetector()));
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/face_detection_with_contour.png', fit: BoxFit.cover, height: 120,),
              Text('Face Detection'.toUpperCase(), style: TextStyle(),)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _title(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _objectDetection(),
                  _textRecognition(),
                  _faceDetection(),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: [
                    Text('Developed by', style: GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.w300),),
                    Text('Harsh kumar', style: GoogleFonts.homemadeApple(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.red),),
                    Text('Under Guidance of', style: GoogleFonts.roboto(fontSize: 18.0, fontWeight: FontWeight.w300),),
                    Text('Dr. Manoj Kumar Mishra', style: GoogleFonts.sourceSansPro(fontSize: 18.0, fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
