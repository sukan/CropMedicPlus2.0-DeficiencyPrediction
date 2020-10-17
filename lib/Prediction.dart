import 'dart:io';
import 'package:cropmedic/Login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'homeScreenDisorderDesc.dart';

class DetectMain extends StatefulWidget {
  @override
  _DetectMainState createState() => new _DetectMainState();
}

class _DetectMainState extends State<DetectMain> {
  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;
  bool dialVisible = true;

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cropmedicplus2.appspot.com');

  StorageUploadTask _uploadTask;

  _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_image);
    });
    print("upload");
    return printValue(filePath);
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/mobilenet.tflite",
        labels: "assets/labels.txt",
      );
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  // run prediction using TFLite on given image
  Future predict(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        // required
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 2,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
        );

    print(recognitions);

    await _startUpload();
    setState(() {
      _recognitions = recognitions;
    });
    // _startUpload();
  }

  // Send image to predict method selected from gallery or camera
  sendImage(File image) async {
    if (image == null) return;
    await predict(image);



    // Get the width and height of selected image
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image;
          });
        })));

  }

  // Select image from gallery
  selectFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  // Select image from camera
  selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    sendImage(image);
  }

  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {});
    });
  }

  Widget printValue(rcg) {
    if (rcg == null) {
      return Text('',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      return Center(
        child: Text("Are you Sure! Is this a Disorder?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Center(
        child: Text(
          "Results: " + _recognitions[0]['label'].toString() + "\n\nDegree: ",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // gets called every time the widget need to re-render or build
  @override
  Widget build(BuildContext context) {
    // get the width and height of current screen the app is running on
    Size size = MediaQuery.of(context).size;

    // initialize two variables that will represent final width and height of the segmentation
    // and image preview on screen
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      // ratio width and ratio height will given ratio to
      // scale up or down the preview image
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW * .90;
      finalH = _imageHeight * ratioH * .50;
    }

    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning';
      }
      if (hour < 17) {
        return 'Good Afternoon';
      }
      return 'Good Evening';
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetectMain())),
        ),
        title: Text(
          "Crop Medic Plus 2.0",
          style: TextStyle(color: Colors.white), textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
        backgroundColor: Colors.teal,
        centerTitle: false,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: _image == null
                ? <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 14, top: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: greeting(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                    TextSpan(
                                        text: ' User!',
                                        style: TextStyle(
                                            fontFamily: 'ConcertOne-Regular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Browse and Detect the disorder in one click.'),
                            ],
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.transparent,
                          //   radius: 30,
                          //   child: InkWell(
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => Login()));
                          //     },
                          //     child: ClipOval(
                          //         child: Image.asset(
                          //       'assets/boy.jpeg',
                          //       // Photo from https://unsplash.com/photos/QXevDflbl8A
                          //       fit: BoxFit.cover,
                          //       width: 55.0,
                          //       height: 55.0,
                          //     )),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    DisorderList(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "  Select or capture the plant leaf to predict disorder:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      ]),
                    )
                  ]
                : <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "",
                            style: TextStyle(fontSize: 22, color: Colors.teal),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.file(_image,
                              fit: BoxFit.fill, width: finalW, height: finalH
                          ),
                          // _startUpload(),
                        ],
                      ),
                    ),
                  ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: printValue(_recognitions),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(color: Colors.white, size: 25),
        visible: dialVisible,
        curve: Curves.bounceInOut,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Toggle',
        heroTag: 'toggele-hero-tag',
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        overlayOpacity: 0.7,
        elevation: 10.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.camera,
                size: 24,
              ),
              backgroundColor: Colors.redAccent,
              label: 'Camera',
              labelStyle: TextStyle(
                fontSize: 18.0,
              ),
              onTap: () => selectFromCamera()),
          SpeedDialChild(
              child: Icon(
                Icons.image,
                size: 24,
              ),
              backgroundColor: Colors.blueAccent,
              label: 'Gallery',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => selectFromGallery()),
        ],
      ),
    );
  }
}
