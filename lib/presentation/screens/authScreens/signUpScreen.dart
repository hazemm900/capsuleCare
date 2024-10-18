import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myTextFormField.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/my_colors.dart';
import '../../../core/localization/generated/l10n.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> gender = ["male", "female"];
  String? selectedGender;

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

  Widget buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).gender,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        DropdownButton(
          hint: Text(S.of(context).genderSelection),
          value: selectedGender,
          onChanged: (newValue) async{
            setState(() {
              selectedGender = newValue;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('gender',selectedGender!);
          },
          items: gender.map((location) {
            return DropdownMenuItem(
              child: new Text(location),
              value: location,
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> saveBirthday(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday', date.toIso8601String());
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update the selected date
      });
      await saveBirthday(picked); // Save the selected date
    }
  }

  Widget buildBirthDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).birthday),
        SizedBox(height: 8.h,),
        CustomElevatedButton(
            child: CustomElevatedButton.iconTextButtonChild(
                Icons.calendar_month_outlined, S.of(context).birthday),
            backgroundColor: MyColors.myYellow,
            onPressed: () => _selectDate(context)),
      ],
    );
  }

  Widget buildSignUpButton() {
    return CustomElevatedButton(
      child: CustomElevatedButton.iconTextButtonChild(
          Icons.navigate_next, S.of(context).nextButton),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Form is valid!')),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userName', nameController.text);
          await prefs.setString('userPhone', phoneController.text);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TestNavigationBottom()));
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
                  clipText: S.of(context).signUp,
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
                        height: 16.h,
                      ),
                      buildBirthDaySelector(),
                      SizedBox(
                        height: 16.h,
                      ),
                      buildGenderSelector(),
                      SizedBox(
                        height: 24.h,
                      ),
                      buildSignUpButton()
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
