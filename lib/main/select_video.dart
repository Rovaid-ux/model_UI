import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_ui/widgets/style.dart';
import 'package:video_player/video_player.dart';

class SelectVideo extends StatefulWidget {
  const SelectVideo({Key? key}) : super(key: key);

  @override
  _SelectVideoState createState() => _SelectVideoState();
}

class _SelectVideoState extends State<SelectVideo> {
  File? _video;
  File? _cameraVideo;
  final picker = ImagePicker();
  late VideoPlayerController _videoPlayerController;
  late VideoPlayerController _cameraVideoPlayerController;

  _pickVideo() async {
    XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    _video = File(pickedFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    XFile? pickedFile = await picker.pickVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile!.path);

    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo!)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController.play();
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.9],
            colors: [
              const Color(0xFF5E7CD6),
              const Color(0xFF071E47),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              style.box2,
              Text(
                'Select Video',
                style: style.home1,
              ),
              style.box3,
              _video != null && _videoPlayerController.value.isInitialized
                  ? SizedBox(
                height: 330,
                width: MediaQuery.of(context).size.width/1.4,
                    child: AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                  )
                  : Text(
                      "Click on select Video",
                      style: TextStyle(fontSize: 18.0),
                    ),
              GestureDetector(
                onTap: () {
                  _pickVideo();
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 170,
                  padding: style.pad1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF134497),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    'select Video',
                    style: style.home1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              style.box10,
              _cameraVideo != null &&
                      _cameraVideoPlayerController.value.isInitialized
                  ? SizedBox(
                height: 330,
                width: MediaQuery.of(context).size.width/1.4,
                    child: AspectRatio(
                        aspectRatio:
                            _cameraVideoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_cameraVideoPlayerController),
                      ),
                  )
                  : Text(
                      "Click on camera roll",
                      style: TextStyle(fontSize: 18.0),
                    ),
              GestureDetector(
                onTap: () {
                  _pickVideoFromCamera();
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 170,
                  padding: style.pad1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF134497),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    'Camera Roll',
                    style: style.home1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
