import 'package:acr_ai_flutter/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  CameraImage imgCam;
  CameraController camCtrl;
  bool isWorking = false;
  String result = "";



  initCamera(){
    camCtrl = CameraController(cameras[0], ResolutionPreset.medium);
    camCtrl.initialize().then((value) {
      if(!mounted){
        return;
      }

      setState(() {

        camCtrl.startImageStream((imageStream) => {
          if(!isWorking){

            isWorking =  true,
            imgCam = imageStream,
            runModelOnFrame()

          }

        });
      });

    });

  }



  loadModel() async {

    await Tflite.loadModel(model:" assets/model_unquant.tflite",labels: "assets/labels.txt");

  }


  runModelOnFrame()async{

    if(imgCam != null){

      var recognition = await Tflite.runModelOnFrame(bytesList: imgCam.planes.map((plane)  {
        return plane.bytes;
      }).toList(),

        imageHeight: imgCam.height,
        imageWidth: imgCam.width,
        imageMean:  0.0,
        imageStd: 255.0,
        rotation: 90,
        numResults: 2,
        threshold: .1,
        asynch: true


      );

      print(recognition.length.toString());

      setState(() {
        result = "";

      });



      recognition.forEach((element) {
        setState(() {
          print(recognition.length.toString());
          result += element["label"];
        });
      });

      setState(() {
        isWorking = false;

      });

    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
    initCamera();

  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.black,
          title: Padding(padding: EdgeInsets.only(top: 40.0),
          child: Center(
            child: Text(result,style: TextStyle(backgroundColor: Colors.black,fontSize: 32,color: Colors.redAccent),),

          ),

          ),



        ),


        body: Column(

          children:<Widget> [
            Positioned(
              top: 0,
              left: 0,
              width: size.width,
              height: size.height - 100,
              child: Container(
                  height: size.height - 100,
                  child: (!camCtrl.value.isInitialized)
                      ? Container()
                      : AspectRatio(
                          aspectRatio: camCtrl.value.aspectRatio,
                          child: CameraPreview(camCtrl),
                        )),
            )
          ],




        ),




      )),



    );
  }
}
