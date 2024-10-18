import 'dart:async';

import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController = StreamController();

  String? currentText;

  Widget buildPinCodeTextFiled(){
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          activeColor: MyColors.myGrey,
          selectedColor: MyColors.myGrey,
          inactiveColor: MyColors.myGrey,
          disabledColor: MyColors.myGrey,
          selectedFillColor: MyColors.myGrey,
          inactiveFillColor: MyColors.myGrey,
          errorBorderColor: MyColors.myGrey),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      errorAnimationController: errorController,
      controller: textEditingController,
      onCompleted: (v) {
        print("Completed");
      },
      onChanged: (value) {
        print(value);
        setState(() {
          currentText = value;
        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: (context),
    );
  }

  Widget buildVerificationBody(){
    return Column(
      children: [
        Text(
          S.of(context).verificationMessage,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          S.of(context).enterAuthCode,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 32.h,
        ),
        buildPinCodeTextFiled(),
        SizedBox(
          height: 64.h,
        ),
        CustomElevatedButton(
          child: CustomElevatedButton.iconTextButtonChild(
              Icons.navigate_next, S.of(context).nextButton),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appBarTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const MyWaveClipper(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildVerificationBody(),
            ),
          ],
        ),
      ),
    );
  }
}
