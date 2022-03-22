import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main/home.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Home()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Impose Estimation',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              SizedBox(height: 20,),
              Container(
                height: 350,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Icon(Icons.ac_unit, color: Colors.white,size: 26,),
              ),
              CircularProgressIndicator(color: Colors.white,semanticsValue: 'not',strokeWidth: 3.3,)
            ],
          ),
        ),
      ),
    );
  }
}
