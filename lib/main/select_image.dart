import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_ui/widgets/global_variables.dart';
import 'package:tflite/tflite.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key}) : super(key: key);

  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? _image;
  List<dynamic>? _recognitions;
  bool selection = false;
  double? _imageHeight;
  double? _imageWidth;
  ImagePicker? imagePicker;
  String? res;

  var leftEyePosImage = Vector(0, 0);
  var rightEyePosImage = Vector(0, 0);
  var leftShoulderPosImage = Vector(0, 0);
  var rightShoulderPosImage = Vector(0, 0);
  var leftHipPosImage = Vector(0, 0);
  var rightHipPosImage = Vector(0, 0);
  var leftElbowPosImage = Vector(0, 0);
  var rightElbowPosImage = Vector(0, 0);
  var leftWristPosImage = Vector(0, 0);
  var rightWristPosImage = Vector(0, 0);
  var leftKneePosImage = Vector(0, 0);
  var rightKneePosImage = Vector(0, 0);
  var leftAnklePosImage = Vector(0, 0);
  var rightAnklePosImage = Vector(0, 0);

  pickImage() async {
    var image = await imagePicker!.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
      predictImage(_image!);
    });
  }

  pickGallery() async {
    var image = await imagePicker!.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
      predictImage(_image!);
    });
  }

  Future loadModel() async {
    try {
      res = await Tflite.loadModel(
        model: "assets/posenet_mv1_075_float_from_checkpoints.tflite",
        // useGpuDelegate: true,
      );
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + res.toString());
    } catch (e) {
      // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $e');
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Failed to load model.');
    }
  }

  Future predictImage(File image) async {
    if (image == null) return;
    poseNet(image);
    // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>imagepath: ${image.path}');

    new FileImage(image)
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageHeight = info.image.height.toDouble();
        _imageWidth = info.image.width.toDouble();
        // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>img height: ${_imageHeight}');
        // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>img width: ${_imageWidth}');
      });
    }));
    setState(() {
      _image = image;
    });
  }

  //TODO perform inference using posenet model
  Future poseNet(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runPoseNetOnImage(
      threshold: 0.7,
      path: image.path,
      numResults: 1,
    );
    print(
        '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> recognitions: ${recognitions}');

    setState(() {
      _recognitions = recognitions!;
      // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> _recognitions: ${_recognitions}');
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print(
        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Inference took ${endTime - startTime}ms ");
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  List<Widget> renderKeypoints(Size screen) {
    if (_recognitions == null) return [];
    if (_imageHeight == null || _imageWidth == null) return [];
    double factorX = screen.width;
    double factorY = _imageHeight! / _imageWidth! * screen.width;

    var lists = <Widget>[];
    _recognitions!.forEach((re) {
      print(re['keypoints']);

      var list = re["keypoints"].values.map<Widget>((k) {
        print(k['score']);
        var _x = k["x"];
        var _y = k["y"];
        var x, y;
        double score;
        score = k["score"];
        x = _x * factorX;
        y = _y * factorY;
        _getKeyPoints(k, x, y, screen, score);
        // paintStack(k: k);
        return Positioned(
          left: x - 6,
          top: y - 6,
          width: 100,
          height: 15,
          child: k['score'] >= 0.2
              ? Container(
                  child: Text(
                    "●",
                      // ${k["part"]}
                    style: TextStyle(
                      color: Color.fromRGBO(37, 213, 253, 1.0),
                      fontSize: 12.0,
                    ),
                  ),
                )
              : Container(),
        );
        // }
      }).toList();

      // _postureAccordingToExercise(inputArr!);
      // inputArr!.clear();

      lists..addAll(list);
    });
    //lists.clear();

    return lists;
  }

  void _getKeyPoints(k, x, y, Size screen, double score) {
    if (k["part"] == 'leftEye') {
      leftEyePosImage.x = x - 6;
      leftEyePosImage.y = y - 6;
    }
    if (k["part"] == 'rightEye') {
      rightEyePosImage.x = x - 6;
      rightEyePosImage.y = y - 6;
    }
    if (k["part"] == 'leftShoulder') {
      leftShoulderPosImage.x = x - 6;
      leftShoulderPosImage.y = y - 6;
    }
    if (k["part"] == 'rightShoulder') {
      rightShoulderPosImage.x = x - 6;
      rightShoulderPosImage.y = y - 6;
    }
    if (k["part"] == 'leftElbow') {
      leftElbowPosImage.x = x - 6;
      leftElbowPosImage.y = y - 6;
    }
    if (k["part"] == 'rightElbow') {
      rightElbowPosImage.x = x - 6;
      rightElbowPosImage.y = y - 6;
    }
    if (k["part"] == 'leftWrist') {
      leftWristPosImage.x = x - 6;
      leftWristPosImage.y = y - 6;
    }
    if (k["part"] == 'rightWrist') {
      rightWristPosImage.x = x - 6;
      rightWristPosImage.y = y - 6;
    }
    if (k["part"] == 'leftHip') {
      leftHipPosImage.x = x - 6;
      leftHipPosImage.y = y - 6;
    }
    if (k["part"] == 'rightHip') {
      rightHipPosImage.x = x - 6;
      rightHipPosImage.y = y - 6;
    }
    if (k["part"] == 'leftKnee') {
      leftKneePosImage.x = x - 6;
      leftKneePosImage.y = y - 6;
    }
    if (k["part"] == 'rightKnee') {
      rightKneePosImage.x = x - 6;
      rightKneePosImage.y = y - 6;
    }
    if (k["part"] == 'leftAnkle') {
      leftAnklePosImage.x = x - 6;
      leftAnklePosImage.y = y - 6;
    }

    if (k["part"] == 'rightAnkle') {
      rightAnklePosImage.x = x - 6;
      rightAnklePosImage.y = y - 6;
    }
  }

  paintStack() {
    return Stack(
      children: [
        CustomPaint(
          painter: MyPainter(
            left: leftShoulderPosImage,
            right: rightShoulderPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: leftElbowPosImage,
            right: leftShoulderPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: leftWristPosImage,
            right: leftElbowPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: rightElbowPosImage,
            right: rightShoulderPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: rightWristPosImage,
            right: rightElbowPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: leftShoulderPosImage,
            right: leftHipPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: leftHipPosImage,
            right: leftKneePosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: leftKneePosImage,
            right: leftAnklePosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: rightShoulderPosImage,
            right: rightHipPosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: rightHipPosImage,
            right: rightKneePosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: rightKneePosImage,
            right: rightAnklePosImage,
          ),
        ),
        CustomPaint(
          painter: MyPainter(
            left: leftHipPosImage,
            right: rightHipPosImage,
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0,
      left: 0,
      width: size.width,
      // height: size.height,
      child: _image == null
          ? Center(
          child: Container(
              child: Icon(
                Icons.image_rounded,
                color: Colors.white,
                size: 60,
              )))
          : Image.file(_image!),
    ));



    stackChildren.add(paintStack() );





    //TODO draw points
    stackChildren.addAll(renderKeypoints(size));
    //TODO bottom bar code
    stackChildren.add(
      Container(
        height: size.height,
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: pickImage,
                child: Icon(
                  Icons.camera,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
              ElevatedButton(
                onPressed: pickGallery,
                child: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 40),
        color: Colors.black,
        child: Stack(
          children: stackChildren,
        ),
      ),
    );
  }
}
