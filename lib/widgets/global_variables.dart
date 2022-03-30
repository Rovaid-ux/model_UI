import 'package:flutter/material.dart';

class Vector {
  double x, y;
  Vector(this.x, this.y);
}

class MyPainter extends CustomPainter {
  Vector? left;
  Vector? right;
  // Color? color;
  MyPainter({this.left, this.right,});
  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(left!.x, left!.y);
    final end = Offset(right!.x, right!.y);
    final paint = Paint()
      ..color = Colors.white //Colors.blue
      ..strokeWidth = 4;
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}