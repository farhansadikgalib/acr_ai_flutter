import 'package:acr_ai_flutter/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: HomePage(),

      image: Image.asset("assets/av.png"),photoSize: 75,backgroundColor: Colors.white,
      loaderColor: Colors.redAccent,
      loadingText: Text("Developed by Farhan",style: TextStyle(color: Colors.black,fontSize: 16.0),),


    );
  }
}
