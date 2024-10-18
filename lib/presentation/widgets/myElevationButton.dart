import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? MyColors.myGreen,
        shape: const StadiumBorder(),
        minimumSize: Size(double.infinity, 50.sp),
      ),
      child: child,
    );
  }

  /// Static method to create a text-only button child
  static Widget textButtonChild(String text, {TextStyle? textStyle}) {
    return Text(
      text,
      style: textStyle ?? TextStyle(fontSize: 20.sp, color: Colors.white),
    );
  }

  /// Static method to create a text + icon button child
  static Widget iconTextButtonChild(IconData icon, String text,
      {TextStyle? textStyle, Color iconColor = Colors.white}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: textStyle ?? TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        SizedBox(width: 8.w),
        Icon(icon, color: iconColor),

      ],
    );
  }
}
