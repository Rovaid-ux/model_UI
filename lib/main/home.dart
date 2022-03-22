import 'package:flutter/material.dart';
import 'package:model_ui/main/select_image.dart';
import 'package:model_ui/main/select_video.dart';

import 'live_camera.dart';


class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const _widgetOptions = <Widget>[
   SelectImage(),
    SelectVideo(),
    LiveCamera()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                title: Text('select Image'),
                backgroundColor: Colors.black87),
            BottomNavigationBarItem(

                icon: Icon(Icons.camera_alt),
                title: Text('Select Video'),
                backgroundColor: Colors.black87),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_front),
              title: Text('Live Camera'),
              backgroundColor: Colors.black87,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white60,unselectedItemColor: Colors.white24,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
