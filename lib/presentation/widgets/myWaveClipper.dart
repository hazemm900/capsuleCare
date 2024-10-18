import 'package:capsule_care/core/constants/wavyClipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyWaveClipper extends StatelessWidget {
  const MyWaveClipper({super.key,  this.clipText});

  final String? clipText;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        width: double.infinity,
        height: 100.h,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            clipText ?? " ",
            style: TextStyle(fontSize: 36.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
