
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
GlobalVariables style = GlobalVariables();

class GlobalVariables {


  TextStyle home1 = TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white);
  TextStyle home2 = TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black.withAlpha(180));
  SizedBox box1 = SizedBox(height: 4,);
  SizedBox box2 = SizedBox(height: 80,);
  SizedBox box3 = SizedBox(height: 40,);
  SizedBox box4 = SizedBox(height: 20,);
  SizedBox box10 = SizedBox(height: 10,);
  EdgeInsets pad1 = EdgeInsets.symmetric(horizontal: 22,vertical: 17);
  static height(BuildContext? context){
    MediaQuery.of(context!).size.height;
  }

}