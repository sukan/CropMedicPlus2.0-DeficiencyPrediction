import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';

import 'Prediction.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplash(
      imagePath: 'assets/icon.PNG',
      home: DetectMain(),
      duration: 2500,
      type: AnimatedSplashType.StaticDuration,
    )
  ));
}


