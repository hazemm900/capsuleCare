import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/editMedicineScreen.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/madice_alaram.dart';

class MedicineDetailsScreen extends StatefulWidget {
  final Map medicine;

  MedicineDetailsScreen({Key? key, required this.medicine}) : super(key: key);

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  final SQDataBase sqDataBase = SQDataBase();

  Future<List<MedicineAlarm>> getAlarmsForMedicine(int medicineId) async {
    // Fetch alarms associated with the given medicineId
    List<Map> results = await sqDataBase.readData(
        "SELECT * FROM MedicineAlarms WHERE medicineId = $medicineId");
    return results.map((alarm) => MedicineAlarm.fromMap(alarm)).toList();
  }

  Future<void> _deleteMedicine(BuildContext context) async {
    // Step 1: Get all alarms for the current medicine
    List<MedicineAlarm> alarms =
        await getAlarmsForMedicine(widget.medicine['id']);

    // Step 2: Cancel all scheduled notifications associated with these alarms
    for (MedicineAlarm alarm in alarms) {
      await AwesomeNotifications().cancel(alarm
          .id!); // Assuming alarm.notificationId stores the notification ID
    }

    // Step 3: Delete the medicine from the database
    int response = await sqDataBase.deleteDataSQFLite(
      "MedicineDetails",
      "id = ${widget.medicine['id']}",
    );

    if (response > 0) {
      // Navigate back to the home screen after deletion
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TestNavigationBottom()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).medicineDeletedSuccessfully)),
      );
    } else {
      // Show an error message if deletion failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).deleteMedicineFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).medicineDetails),
      ),
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
                      S.of(context).medicineName +
                          ': ${widget.medicine['medicineName']}',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: MyColors.myLightBlue,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(S.of(context).total,
                      style: TextStyle(
                          color: MyColors.myBlue, fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${widget.medicine['totalNumberOfCapsules']}",
                    style: TextStyle(
                      color: MyColors.myLightBlue,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(S.of(context).remainderOfCapsules,
                      style: TextStyle(
                          color: MyColors.myBlue, fontWeight: FontWeight.w900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "${widget.medicine['remainderOfCapsules']}",
                    style: TextStyle(
                      color: MyColors.myLightBlue,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(S.of(context).isRecurring,
                      style: TextStyle(
                          color: MyColors.myBlue, fontWeight: FontWeight.w900)),
                  SizedBox(height: 8.h),
                  Text(
                    "${widget.medicine['isRecurring']}",
                    style: TextStyle(
                      color: MyColors.myLightBlue,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: MyColors.myBlue,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        S.of(context).schedule,
                        style: TextStyle(
                            color: MyColors.myBlue,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  FutureBuilder<List<MedicineAlarm>>(
                    future: getAlarmsForMedicine(widget.medicine['id']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text(S.of(context).noAlarmsSet);
                      } else {
                        final alarms = snapshot.data!;
                        return Column(
                          children: alarms.map((alarm) {
                            return ListTile(
                              title: Text(
                                  S.of(context).alarmAt + '${alarm.alarmTime}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  // Step 1: Cancel the scheduled notification using the notificationId from the alarm
                                  await AwesomeNotifications()
                                      .cancel(alarm.id!);

                                  // Step 2: Delete the alarm from the database
                                  int response =
                                      await sqDataBase.deleteDataSQFLite(
                                    "MedicineAlarms",
                                    "id = ${alarm.id}",
                                  );

                                  // Step 3: Update the UI after deletion
                                  if (response > 0) {
                                    setState(() {
                                      // Remove the alarm from the list of alarms
                                      alarms.remove(alarm);
                                    });

                                    // Optionally, show a success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(S.of(context).alarmDeleted)),
                                    );
                                  } else {
                                    // Show an error message if deletion failed
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              S.of(context).deleteAlarmFailed)),
                                    );
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          child: CustomElevatedButton.iconTextButtonChild(
                              Icons.edit_outlined, S.of(context).editMedicine),
                          backgroundColor: MyColors.myYellow,
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditMedicine(
                                  medicineName: widget.medicine['medicineName'],
                                  totalNumberOfCapsules:
                                      widget.medicine['totalNumberOfCapsules'],
                                  remainderOfCapsules:
                                      widget.medicine['remainderOfCapsules'],
                                  id: widget.medicine['id'],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomElevatedButton(
                          child: CustomElevatedButton.iconTextButtonChild(
                              Icons.delete_outline,
                              S.of(context).deleteMedicine),
                          onPressed: () => _deleteMedicine(context),
                          backgroundColor: MyColors.myOrange,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
