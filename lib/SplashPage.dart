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

      image: Image.asset("assets/av.png"),

      title: Text("Avengers",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold,color: Colors.purple )),
      loaderColor: Colors.purple,
      loadingText: Text("Developed by Farhan",style: TextStyle(color: Colors.black,fontSize: 16.0),),


    );
  }
}
