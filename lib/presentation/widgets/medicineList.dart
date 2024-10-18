
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/medicineDetailsScreen.dart';
import 'package:capsule_care/presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineList extends StatefulWidget {
  final VoidCallback onMedicineUpdate; // Callback to refresh the parent UI

  const MedicineList({super.key, required this.onMedicineUpdate});

  @override
  State<MedicineList> createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  SQDataBase sqDataBase = SQDataBase();

  bool isLoading = true;
  List medicine = [];

  Future readData() async {
    List<Map> response = await sqDataBase.readDataSQFLite("MedicineDetails");
    setState(() {
      medicine = response;
      isLoading = false;
    });
  }

  Future<void> updateCapsuleCount(int id, int currentCount) async {
    // Decrement the capsule count by 1
    int newCount = currentCount - 1;

    // Update the remainder of capsules in the database
    await sqDataBase.updateDataSQFLite(
      'MedicineDetails',
      {
        'remainderOfCapsules': newCount,
      },
      'id = $id',
    );

    // Refresh the UI after updating the database
    widget.onMedicineUpdate(); // Notify parent to refresh the UI
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true; // Set loading to true while refreshing
    });
    await readData(); // Fetch the data again
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Loading..."),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          )
        : medicine.isEmpty // Check if the medicine list is empty
            ? Center(
                child: Text(
                  S.of(context).noMedicinesAdded,
                  // Localized string for "No medicines have been added yet."
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                  ),
                ),
              )
            : RefreshIndicator(
                // Wrap the ListView with RefreshIndicator
                onRefresh: _refresh, // Call the refresh function
                child: ListView.builder(
                  itemCount: medicine.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicineDetailsScreen(
                                medicine: medicine[i],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${S.of(context).medicineName}: ${medicine[i]['medicineName']}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? MyColors.myBlue // Dark mode color
                                        : MyColors
                                            .myLightBlue, // Light mode color
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${S.of(context).remainderOfCapsules}: ${medicine[i]['remainderOfCapsules']}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                // Button to take medicine and decrement capsule count
                                ElevatedButton(
                                  onPressed: () {
                                    int remainder =
                                        medicine[i]['remainderOfCapsules'];
                                    if (remainder > 0) {
                                      updateCapsuleCount(
                                        medicine[i]['id'],
                                        remainder,
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TestNavigationBottom()),
                                        (route) => false,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              S.of(context).noCapsulesLeft),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(S.of(context).takeMedicineNow),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
  }
}
