import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';

import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myTextFormField.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/madice_alaram.dart';

class EditMedicine extends StatefulWidget {
  final String? medicineName;
  final int? totalNumberOfCapsules;
  final int? remainderOfCapsules;
  final int? id;

  const EditMedicine(
      {super.key,
      this.medicineName,
      this.totalNumberOfCapsules,
      this.remainderOfCapsules,
      this.id});

  @override
  State<EditMedicine> createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  SQDataBase sqDataBase = SQDataBase();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController medicineName = TextEditingController();
  TextEditingController totalNumberOfCapsules = TextEditingController();
  TextEditingController remainderOfCapsules = TextEditingController();
  bool shouldRepeatAlarm = false;

  @override
  void initState() {
    super.initState();
    medicineName.text = widget.medicineName ?? '';
    totalNumberOfCapsules.text = widget.totalNumberOfCapsules?.toString() ?? '';
    remainderOfCapsules.text = widget.remainderOfCapsules?.toString() ?? '';
  }

  // Method to fetch alarms for the given medicine
  Future<List<MedicineAlarm>> getAlarmsForMedicine(int medicineId) async {
    List<Map> results = await sqDataBase.getAlarmsForMedicine(medicineId);
    return results.map((alarm) => MedicineAlarm.fromMap(alarm)).toList();
  }

  // Method to add a new alarm to the database and schedule the notification
  Future<void> addNewAlarm(int medicineId, DateTime newTime) async {
    String formattedTime = "${newTime.hour}:${newTime.minute}";

    int alarmId = await sqDataBase.insertDataSQFLite(
      'MedicineAlarms',
      {
        'medicineId': medicineId,
        'alarmTime': formattedTime,
      },
    );

    if (alarmId > 0) {
      // Schedule notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: alarmId,
          // Use the alarmId for the notification ID
          channelKey: 'medicine_channel_test',
          title: S.of(context).medicineReminder,
          body: '${S.of(context).timeToTakeMedicine}: ${medicineName.text}',
          notificationLayout: NotificationLayout.Default,
          wakeUpScreen: true,
          fullScreenIntent: true,
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'TAKE_MEDICINE', label: S.of(context).takeNow),
          NotificationActionButton(key: 'SNOOZE', label: S.of(context).snooze),
          NotificationActionButton(
              key: 'TAKE_LATER', label: S.of(context).takeLater),
        ],
        schedule: NotificationCalendar(
          year: newTime.year,
          month: newTime.month,
          day: newTime.day,
          hour: newTime.hour,
          minute: newTime.minute,
          repeats: shouldRepeatAlarm,
        ),
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).alarmAdded)));
      setState(() {}); // Refresh the UI to show updated alarms
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).addAlarmFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).editMedicine)),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              MyWaveClipper(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: medicineName,
                      labelText: S.of(context).medicineName,
                      prefixIcon: Icons.medical_services_outlined,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      controller: totalNumberOfCapsules,
                      labelText: S.of(context).totalNumberOfCapsules,
                      prefixIcon: Icons.medical_services_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      controller: remainderOfCapsules,
                      labelText: S.of(context).remainderOfCapsules,
                      prefixIcon: Icons.medical_services_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      child: CustomElevatedButton.textButtonChild(
                          S.of(context).addNewAlarm),
                      backgroundColor: MyColors.myYellow,
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (pickedTime != null) {
                          final now = DateTime.now();
                          final newTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          await addNewAlarm(widget.id!, newTime);
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    CheckboxListTile(
                      title: Text(S.of(context).repeatAlarm),
                      value: shouldRepeatAlarm,
                      onChanged: (bool? value) {
                        setState(() {
                          shouldRepeatAlarm = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    FutureBuilder<List<MedicineAlarm>>(
                      future: getAlarmsForMedicine(widget.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text(S.of(context).noAlarmsSet);
                        } else {
                          final alarms = snapshot.data!;
                          return Column(
                            children: alarms.map((alarm) {
                              return ListTile(
                                title: Text(S.of(context).alarmAt +
                                    '${alarm.alarmTime}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () async {
                                    final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                        hour: int.tryParse(alarm.alarmTime
                                                .split(":")[0]) ??
                                            0,
                                        minute: int.tryParse(alarm.alarmTime
                                                .split(":")[1]) ??
                                            0,
                                      ),
                                    );
                                    if (pickedTime != null) {
                                      final now = DateTime.now();
                                      final newTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );
                                      // Cancel old notification
                                      await AwesomeNotifications()
                                          .cancelSchedule(alarm.id!);
                                      // Delete the old alarm from the database
                                      await sqDataBase.deleteDataSQFLite(
                                          'MedicineAlarms', 'id = ${alarm.id}');
                                      // Add the new alarm and schedule notification
                                      await addNewAlarm(widget.id!, newTime);
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      child: CustomElevatedButton.textButtonChild(
                        S.of(context).editMedicine,
                      ),
                      onPressed: () async {
                        // Validate input fields
                        if (medicineName.text.isEmpty ||
                            totalNumberOfCapsules.text.isEmpty ||
                            remainderOfCapsules.text.isEmpty) {
                          // Show a warning if fields are empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(S.of(context).allFieldsRequired)),
                          );
                          return; // Exit if validation fails
                        }

                        // Proceed to update the database
                        try {
                          int response = await sqDataBase.updateDataSQFLite(
                            "MedicineDetails",
                            {
                              "medicineName": medicineName.text,
                              "totalNumberOfCapsules":
                                  totalNumberOfCapsules.text,
                              "remainderOfCapsules": remainderOfCapsules.text,
                            },
                            "id = ${widget.id}",
                          );

                          if (response > 0) {
                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(S.of(context).updateSuccess)),
                            );

                            // Navigate to a different screen
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => TestNavigationBottom(),
                              ),
                              (route) => false,
                            );
                          } else {
                            // Show error message if no rows were updated
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(S.of(context).updateFailed)),
                            );
                          }
                        } catch (e) {
                          // Show error message in case of exception
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text(S.of(context).somethingWentWrong)),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
