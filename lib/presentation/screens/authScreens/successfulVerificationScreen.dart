import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfulVerificationScreen extends StatefulWidget {
  const SuccessfulVerificationScreen({super.key});

  @override
  State<SuccessfulVerificationScreen> createState() => _SuccessfulVerificationScreenState();
}

class _SuccessfulVerificationScreenState extends State<SuccessfulVerificationScreen> {

  Widget buildSuccessfulVerification(){
    return Column(
      children: [
        Text(
          S.of(context).congratulation,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          S.of(context).congratulationMessage,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 64.h,
        ),
        CustomElevatedButton(
            child: CustomElevatedButton.iconTextButtonChild(
                Icons.home, S.of(context).homePageButton),
            onPressed: () {})
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
              child:
              buildSuccessfulVerification(),
            ),
          ],
        ),
      ),
    );
  }
}
