
import 'package:capsule_care/presentation/screens/authScreens/signUpScreen.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/profileScreen.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myTextFormField.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/my_colors.dart';
import '../../../core/localization/generated/l10n.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Widget buildUserNameTextForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).userName,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormField(
          labelText: S.of(context).userName,
          hintText: S.of(context).enterName,
          controller: nameController,
          prefixIcon: Icons.person,
          keyboardType: TextInputType.name,
        ),
      ],
    );
  }

  Widget buildPhoneTextForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).phone,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomTextFormField(
          labelText: S.of(context).phone,
          hintText: S.of(context).enterPhone,
          controller: phoneController,
          prefixIcon: Icons.phone_android_outlined,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget buildLogInButton() {
    return CustomElevatedButton(
      child: CustomElevatedButton.iconTextButtonChild(
          Icons.navigate_next, S.of(context).logIn),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form is valid!')),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userName', nameController.text);
          await prefs.setString('userPhone', phoneController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestNavigationBottom(),
            ),
          );
        } else {
          // If the form is not valid, display an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Form is not valid! Please fill out the required fields.')),
          );
          print("not valid");
        }
      },
      backgroundColor: MyColors.myBlue,
    );
  }

  Widget buildCreateAccountButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          S.of(context).doNotHaveAccount,
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appBarTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                MyWaveClipper(
                  clipText: S.of(context).logIn,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).welcomeMessage,
                        style: TextStyle(
                            fontSize: 24.sp, color: Colors.grey.shade500),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildUserNameTextForm(),
                      SizedBox(
                        height: 16.h,
                      ),
                      buildPhoneTextForm(),
                      SizedBox(
                        height: 64.h,
                      ),
                      buildLogInButton(),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildCreateAccountButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
