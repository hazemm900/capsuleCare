
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/addNewMedicineScreen.dart';
import 'package:capsule_care/presentation/widgets/myDrawer.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<String?> getValueOfUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'userName'); // Replace 'key' with the specific key used to save the value.
  }

  Future<String?> getValueOfUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'userPhone'); // Replace 'key' with the specific key used to save the value.
  }

  Future<String?> getValueOfGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'gender'); // Replace 'key' with the specific key used to save the value.
  }

  String? userName;
  String? userPhone;
  String? userGender;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    loadValue();
    loadBirthday();
  }

  void loadValue() async {
    userName = await getValueOfUserName() ?? " ";
    userPhone = await getValueOfUserPhone() ?? " ";
    userGender = await getValueOfGender() ?? " ";
    setState(() {});
  }

  int? age;

  Future<void> loadBirthday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedDate = prefs.getString('birthday');
    if (savedDate != null) {
      setState(() {
        selectedDate = DateTime.parse(savedDate);
        age = calculateAge(selectedDate!); // Calculate the age
      });
    }
  }

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyWaveClipper(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    S.of(context).welcome + userName.toString(),
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: MyColors.myLightBlue,
                        fontWeight: FontWeight.w900),
                  )),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: MyColors.myBlue,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        S.of(context).phone,
                        style: TextStyle(
                            color: MyColors.myBlue,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    userPhone.toString(),
                    style: TextStyle(color: MyColors.myLightBlue),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(S.of(context).birthday,
                      style: TextStyle(
                          color: MyColors.myBlue,
                          fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    selectedDate != null
                        ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                        : '',
                    style: TextStyle(color: MyColors.myLightBlue),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(S.of(context).age,
                      style: TextStyle(
                          color: MyColors.myBlue,
                          fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    age != null ? age.toString() : '',
                    style: TextStyle(color: MyColors.myLightBlue),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    S.of(context).gender,
                    style: TextStyle(
                        color: MyColors.myBlue,
                        fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(userGender.toString(),
                      style: TextStyle(color: MyColors.myLightBlue)),
                  SizedBox(
                    height: 32.h,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          child: CustomElevatedButton.iconTextButtonChild(
                              Icons.add, S.of(context).addNewMedicine),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddNewMedicineScreen()));
                          },
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            S.of(context).logOut,
                            style: TextStyle(color: MyColors.myOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
