import 'package:capsule_care/presentation/widgets/myTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFullTextForm extends StatelessWidget {
  const MyFullTextForm({super.key, this.controller, required this.formName, required this.formLableText, this.formPrefixIcon, required this.formHintText, required this.keyboardType});

  final String formName;
  final TextEditingController? controller;
  final String formLableText;
  final String formHintText;
  final IconData? formPrefixIcon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormField(
          controller: controller,
          labelText: formLableText,
          hintText: formHintText,
          prefixIcon: formPrefixIcon,
          keyboardType: keyboardType,
        ),
        SizedBox(
          height: 16.h,
        ),
      ],
    );
  }
}
