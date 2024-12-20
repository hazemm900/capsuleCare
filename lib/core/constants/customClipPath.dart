import 'package:flutter/cupertino.dart';

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();

    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width * 0.5, height, width, height -100);
    path.lineTo(width , 0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
  
}