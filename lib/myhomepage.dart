import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'helper/image_classification_helper.dart';
// import 'helper/isolate_inference.dart';
import 'package:image/image.dart' as img;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File image;
  img.Image? bibi;
  List output = [];
  bool loaded = false;
  final picker = ImagePicker();

  ImageClassificationHelper? imageClassificationHelper;
  Map<String, double>? classification;

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    super.initState();
  }

  Future<void> processImage() async {
    // Read image bytes from file
    final imageData = image.readAsBytesSync();

    // Decode image using package:image/image.dart (https://pub.dev/image)
    bibi = img.decodeImage(imageData);
    setState(() {});
    classification = await imageClassificationHelper?.inferenceImage(bibi!);
    loaded = true;
    setState(() {});
  }

  pickCameraImage() async {
    var imagepicked = await picker.pickImage(source: ImageSource.camera);
    if (imagepicked == null) return null;
    setState(() {
      image = File(imagepicked.path);
    });

    processImage();
  }

  pickGalleryImage() async {
    var imagepicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagepicked == null) return null;
    setState(() {
      image = File(imagepicked.path);
    });

    processImage();
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpeg"),
            opacity: 0.3,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Spacer(),
              Text(
                "Hello",
                textScaler: TextScaler.linear(5),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              loaded
                  ? Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.file(
                            image,
                            //fit: BoxFit.fitWidth,
                          ),
                        ),
                        // Text("${output[0]['']}"),
                        if (loaded)
                          ...(classification!.entries.toList()
                                ..sort(
                                  (a, b) => a.value.compareTo(b.value),
                                ))
                              .reversed
                              .take(3)
                              .map(
                                (e) => Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Text(e.key),
                                      const Spacer(),
                                      Text(e.value.toStringAsFixed(2))
                                    ],
                                  ),
                                ),
                              ),

                        SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  : Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    onPressed: pickCameraImage,
                    icon: Icon(Icons.camera_alt_outlined),
                    padding: EdgeInsets.all(15),
                    iconSize: 40,
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  IconButton.filled(
                    onPressed: pickGalleryImage,
                    icon: Icon(Icons.photo_library),
                    padding: EdgeInsets.all(15),
                    iconSize: 40,
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),

      //bottomNavigationBar: BottomNavigationBar(items: I),
    );
  }
}
