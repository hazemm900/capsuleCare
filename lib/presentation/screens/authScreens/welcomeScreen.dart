import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeclomeScreen extends StatelessWidget {
  const WeclomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  S.of(context).welcomeMessage,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 32.h,
                ),
                TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: 2 * 3.14),
                  duration: const Duration(seconds: 10),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.myWhite,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 200.w,
                        height: 200.h,
                        child: const Image(
                          image:
                              AssetImage("assets/images/capsule-medicine.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomElevatedButton(
                    child: CustomElevatedButton.iconTextButtonChild(
                        Icons.assignment_ind, S.of(context).signUp),
                    onPressed: () {},
                  backgroundColor: MyColors.myBlue,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomElevatedButton(
                    child: CustomElevatedButton.iconTextButtonChild(
                        Icons.login, S.of(context).logIn),
                    onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
