import 'package:awesome_notifications/awesome_notifications.dart'; // Import Awesome Notifications
import 'package:capsule_care/business_layer/add_new_medicine/add_new_medicine_cubit.dart';
import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myFullTextForm.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_layer/add_new_medicine/add_new_medicine_state.dart';
import '../../../core/base_widget/custom_snack_bar.dart';
import '../../../core/constants/my_colors.dart';
import '../../../core/localization/generated/l10n.dart';

class AddNewMedicineScreen extends StatefulWidget {
  const AddNewMedicineScreen({super.key});

  @override
  State<AddNewMedicineScreen> createState() => _AddNewMedicineScreenState();
}

class _AddNewMedicineScreenState extends State<AddNewMedicineScreen> {
  SQDataBase sqDataBase = SQDataBase();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController medicineName = TextEditingController();
  TextEditingController totalNumberOfCapsules = TextEditingController();
  TextEditingController remainderOfCapsules = TextEditingController();
  List<DateTime> alarms = []; // List to store alarm times
  bool shouldRepeat = false; // Track if the user wants the alarm to repeat

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    medicineName.dispose();
    totalNumberOfCapsules.dispose();
    remainderOfCapsules.dispose();
    super.dispose();
  }

  Widget buildMedicineNameTextField() {
    return MyFullTextForm(
      formName: S.of(context).medicineName,
      formLableText: S.of(context).medicineName,
      controller: medicineName,
      formHintText: S.of(context).addNewMedicine,
      formPrefixIcon: Icons.medical_services_outlined,
      keyboardType: TextInputType.name,
    );
  }

  Widget buildTotalNumTextField() {
    return MyFullTextForm(
      formName: S.of(context).totalNumberOfCapsules,
      formLableText: S.of(context).totalNumberOfCapsules,
      controller: totalNumberOfCapsules,
      formHintText: S.of(context).totalNumberOfCapsules,
      formPrefixIcon: Icons.medical_services_outlined,
      keyboardType: TextInputType.number,
    );
  }

  Widget buildRemainderNumTextField() {
    return MyFullTextForm(
      formName: S.of(context).remainderOfCapsules,
      formLableText: S.of(context).remainderOfCapsules,
      controller: remainderOfCapsules,
      formHintText: S.of(context).remainderOfCapsules,
      formPrefixIcon: Icons.medical_services_outlined,
      keyboardType: TextInputType.number,
    );
  }

  Widget buildRepeatAlarmCheckbox() {
    return CheckboxListTile(
      title: Text(S.of(context).repeatAlarm),
      value: shouldRepeat,
      onChanged: (bool? value) {
        setState(() {
          shouldRepeat = value ?? false;
        });
      },
    );
  }

  Widget buildSetAlarmButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).setAlarm,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8.h),
        CustomElevatedButton(
          backgroundColor: MyColors.myLightOrange,
          onPressed: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                final now = DateTime.now();
                final alarmTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
                alarms.add(alarmTime);
              });
            }
          },
          child: CustomElevatedButton.iconTextButtonChild(
              Icons.alarm_add, S.of(context).setAlarm),
        ),
        SizedBox(height: 16.h),
        buildRepeatAlarmCheckbox(), // Add the checkbox here
        ...alarms.map((alarmTime) {
          return ListTile(
            title: Text(
              '${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  alarms.remove(alarmTime);
                });
              },
            ),
          );
        }).toList(),
        SizedBox(height: 64.h),
      ],
    );
  }

  // Method to show SnackBar
  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //
  //     SnackBar(
  //       backgroundColor: Colors.green,
  //       content: Text(message),
  //
  //       duration: const Duration(
  //           seconds: 3), // Optional: Set the duration for the SnackBar
  //     ),
  //   );
  // }

  Widget buildDoneButton() {
    return BlocBuilder<AddNewMedicineCubit, AddNewMedicineState>(
      builder: (context, state) {
        // var cubit = AddNewMedicineCubit.get(context);
        return CustomElevatedButton(
          child: CustomElevatedButton.iconTextButtonChild(
              Icons.done_all, S.of(context).done),
          onPressed: () async {
            if (!formKey.currentState!.validate()) {
              showSnackBar(context ,  S.of(context).fillAllFields , "error");
              return;
            }

            final totalCapsules = int.tryParse(totalNumberOfCapsules.text);
            final remainderCapsules = int.tryParse(remainderOfCapsules.text);

            if (totalCapsules == null || remainderCapsules == null) {
              showSnackBar(context ,  S.of(context).fillAllFields , "error");
              return;
            }

            try {
              // Insert medicine data into the database
              int medicineId = await sqDataBase.insertDataSQFLite(
                "MedicineDetails",
                {
                  "medicineName": medicineName.text,
                  "totalNumberOfCapsules": totalCapsules,
                  "remainderOfCapsules": remainderCapsules,
                },
              );

              if (medicineId > 0) {
                for (DateTime alarmTime in alarms) {
                  // Insert alarms into the database
                  int alarmId = await sqDataBase.insertDataSQFLite(
                    "MedicineAlarms",
                    {
                      "medicineId": medicineId,
                      "alarmTime": "${alarmTime.hour}:${alarmTime.minute}",
                    },
                  );

                  // Schedule notifications for each alarm
                  await AwesomeNotifications().createNotification(
                    content: NotificationContent(
                      id: alarmId,
                      channelKey: 'medicine_channel_test',
                      title: S.of(context).medicineReminder,
                      body:
                          '${S.of(context).timeToTakeMedicine}: ${medicineName.text}',
                      wakeUpScreen: true,
                      fullScreenIntent: true,
                      customSound: 'resource://raw/iphone_alarm.mp3',
                    ),
                    actionButtons: [
                      NotificationActionButton(
                          key: 'TAKE_MEDICINE', label: S.of(context).takeNow),
                      NotificationActionButton(
                          key: 'SNOOZE', label: S.of(context).snooze),
                      NotificationActionButton(
                        key: 'TAKE_LATER',
                        label: S.of(context).takeLater,
                        buttonType: ActionButtonType.Default,
                      )
                    ],
                    schedule: NotificationCalendar(
                      hour: alarmTime.hour,
                      minute: alarmTime.minute,
                      second: 0,
                      repeats: shouldRepeat, // Use the checkbox value
                    ),
                  );
                }

                // Show success message for adding medicine and alarms
                showSnackBar(context ,  S.of(context).fillAllFields , "success");

                // Clear form fields after successful submission
                medicineName.clear();
                totalNumberOfCapsules.clear();
                remainderOfCapsules.clear();
                alarms.clear();

                // Navigate to the next screen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const TestNavigationBottom(),
                  ),
                  (route) => false,
                );
              } else {
                showSnackBar(context ,  S.of(context).fillAllFields , "error");
              }
            } catch (error) {
              print(error.toString());
              showSnackBar(context ,  S.of(context).fillAllFields , "error");
            }
          },
          // onPressed: () {
          //   AddNewMedicineCubit.get(context).addNewMedicineValidate(context);
          // },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addNewMedicine),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const MyWaveClipper(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildMedicineNameTextField(),
                      buildTotalNumTextField(),
                      buildRemainderNumTextField(),
                      buildSetAlarmButton(),
                      buildDoneButton()
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
