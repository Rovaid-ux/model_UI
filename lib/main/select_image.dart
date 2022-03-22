import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_ui/widgets/style.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key}) : super(key: key);

  @override
  _SelectImageState createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  // bool _loading = true;
  File? _image;
  // List? _output;
  final picker = ImagePicker();

  bool moreDetails = false;

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    // var video = await picker.pickVideo(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
  }

  pickGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                style.box2,
                Text(
                  'Select Image',
                  style: style.home1,
                ),
                style.box3,
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(170),
                            spreadRadius: 5,
                            blurRadius: 7),
                      ]),
                  child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.87,
                            child:
                            Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width/1.2,
                                    height:  300,
                                    child: _image != null? ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: Image.file(
                                          _image!,
                                          fit: BoxFit.contain,
                                        )):Container(),
                                  ),
                                  style.box4,

                                ],
                              ),
                            ),
                          ),
                          style.box4,
                          GestureDetector(
                            onTap: () {
                              pickImage();
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
                                'Take a Photo',
                                style: style.home1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          style.box10,
                          GestureDetector(
                            onTap: () {
                              pickGallery();
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
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
