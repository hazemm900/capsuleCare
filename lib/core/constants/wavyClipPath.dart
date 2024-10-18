import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var waveHeight = size.height / 3;

    // Start from top left
    path.lineTo(0.0, size.height - waveHeight);

    // First curve
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height - waveHeight,
    );

    // Second curve
    path.quadraticBezierTo(
      size.width * 0.75, size.height - 2 * waveHeight,
      size.width, size.height - waveHeight,
    );

    // Line to the bottom right corner
    path.lineTo(size.width, size.height);

    // Line back to the top right corner
    path.lineTo(size.width, 0.0);

    // Close the path to form the shape
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Reclip if the size changes or if the path needs to be recalculated
    return false;
  }
}
