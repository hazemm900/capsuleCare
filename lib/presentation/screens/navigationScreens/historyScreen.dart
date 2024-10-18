import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/medicineDetailsScreen.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/medicineSearchScreen.dart';
import 'package:capsule_care/presentation/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base_widget/custom_appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  SQDataBase sqDataBase = SQDataBase();

  Future<List<Map>> getMedicinesWithNoCapsules() async {
    // Fetch medicines where remainderOfCapsules = 0
    List<Map> results = await sqDataBase.readData(
        "SELECT * FROM MedicineDetails WHERE remainderOfCapsules = 0");
    return results;
  }

  // Function to delete medicine and cancel associated notifications
  Future<void> deleteMedicine(int medicineId) async {
    // Fetch all alarms associated with the medicineId
    List<Map> alarms = await sqDataBase.getAlarmsForMedicine(medicineId);

    // Cancel all scheduled notifications associated with the medicineId
    for (var alarm in alarms) {
      await AwesomeNotifications().cancel(alarm['id']); // Use the alarm ID to cancel the notification
    }

    // Delete from the database
    await sqDataBase.deleteData(
        'DELETE FROM MedicineDetails WHERE id = $medicineId');

    // Refresh the screen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CutsomAppBar(title: S.of(context).medicinesArchive,),
      //
      // drawer: MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Map>>(
            future: getMedicinesWithNoCapsules(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text(S.of(context).noMedicinesHaveFinished));
              } else {
                final medicines = snapshot.data!;

                // Show an alert if there are finished medicines
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (medicines.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(S.of(context).alert),
                          content: Text(S.of(context).someMedicinesHaveFinished),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.of(context).done),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });

                return ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return ListTile(
                      title: Text(medicine['medicineName']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).capsulesRemaining + ' 0'),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to EditMedicine screen with the selected medicine data
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MedicineDetailsScreen(medicine: medicine), // Pass the medicine map
                                      ),
                                    );
                                  },
                                  child: Text(S.of(context).renewMedicine),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.myOrange,
                                  ),
                                  onPressed: () async {
                                    // Delete medicine and cancel notifications
                                    await deleteMedicine(medicine['id']);
                                  },
                                  child: Text(S.of(context).deleteMedicine),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.warning, color: Colors.red),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
