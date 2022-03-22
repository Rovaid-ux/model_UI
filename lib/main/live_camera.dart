import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../main.dart';

// import 'live_camera.dart';
class LiveCamera extends StatefulWidget {
  const LiveCamera({Key? key}) : super(key: key);

  @override
  State<LiveCamera> createState() => _LiveCameraState();
}

class _LiveCameraState extends State<LiveCamera> with WidgetsBindingObserver {
  CameraController? controller;





  //
  //
  //
  // void onNewCameraSelected(CameraDescription cameraDescription) async {
  //   final previousCameraController = controller;
  //   // Instantiating the camera controller
  //   final CameraController cameraController = CameraController(
  //     cameraDescription,
  //     ResolutionPreset.high,
  //     imageFormatGroup: ImageFormatGroup.jpeg,
  //   );
  //
  //   // Dispose the previous controller
  //   await previousCameraController?.dispose();
  //
  //   // Replace with the new controller
  //   if (mounted) {
  //     setState(() {
  //       controller = cameraController;
  //     });
  //   }
  //
  //   // Update UI if controller updated
  //   cameraController.addListener(() {
  //     if (mounted) setState(() {});
  //   });
  //
  //   // Initialize controller
  //   try {
  //     await cameraController.initialize();
  //   } on CameraException catch (e) {
  //     print('Error initializing camera: $e');
  //   }
  //
  //   // Update the Boolean
  //   if (mounted) {
  //     setState(() {
  //       _isCameraInitialized = controller!.value.isInitialized;
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //
  //   // Hide the status bar
  //   SystemChrome.setEnabledSystemUIOverlays([]);
  //   onNewCameraSelected(cameras![0]);
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController? cameraController = controller;
  //
  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }
  //
  //   if (state == AppLifecycleState.inactive) {
  //     // Free up memory when camera not active
  //     cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // Reinitialize the camera with same properties
  //     onNewCameraSelected(cameraController.description);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: controller != null ? CameraPreview(controller!) : Container(child: Text('Bruhh'),),
    );
  }
}

