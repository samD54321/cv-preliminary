import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(home: FacePage(),));
}

class FacePage extends StatefulWidget {
  @override
  createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {

  void _getImageAndDetectFaces() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(
        source: ImageSource.gallery
    );
    var myFile;
    if(imageFile !=null) myFile = File(imageFile.path);
    final inputImage = InputImage.fromFile(myFile);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    
    final List<Face> faces = await faceDetector.processImage(inputImage);
    for (Face face in faces) {
      var rotX = face.headEulerAngleX;
      var rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
      var rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees
      print(rotX);
      print(rotY);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detection Test'),
      ),
      body:Container(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {_getImageAndDetectFaces();},
        tooltip: 'Pick an Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}