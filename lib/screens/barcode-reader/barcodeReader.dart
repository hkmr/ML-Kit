import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeReader extends StatefulWidget {
  @override
  _BarcodeReaderState createState() => _BarcodeReaderState();
}

class _BarcodeReaderState extends State<BarcodeReader> {

  File pickedImage;
  bool isImageLoaded = false;
  String result = "Result : ";

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
      result = "";
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            result = result+" " + word.text;
          });
        }
      }
    }
  }

  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      setState(() {
        result = result + readableCode.displayValue;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition'),
        backgroundColor: Colors.black,
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100.0),
                isImageLoaded
                    ? Center(
                  child: Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(pickedImage), fit: BoxFit.cover))),
                )
                    : Container(),
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text('Pick an image'),
                  onPressed: pickImage,
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text('Read Text'),
                  onPressed: readText,
                ),
                RaisedButton(
                  child: Text('Read Bar Code'),
                  onPressed: decode,
                ),

                Text(result, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ),
    );
  }
}
