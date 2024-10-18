import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final bool isRequired;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      // validator: validator,
      decoration: InputDecoration(
        fillColor: MyColors.myGrey,
        filled: true,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: MyColors.myLightGrey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55.sp),
            borderSide: BorderSide(color: MyColors.myBlue, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(55.sp),
            borderSide: BorderSide(color: MyColors.myDarkGrey)),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        prefixIconColor: MyColors.myLightGrey,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return '$labelText cannot be empty';
        }
        return null;
      },
    );
  }
}
