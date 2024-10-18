import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/medicineSearchScreen.dart';
import 'package:capsule_care/presentation/widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base_widget/custom_appbar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  SQDataBase sqDataBase = SQDataBase();

  Future<List<Map>> getMedicinesWithLowCapsules() async {
    // Fetch medicines where remainderOfCapsules <= 3
    List<Map> results = await sqDataBase.readData(
        "SELECT * FROM MedicineDetails WHERE remainderOfCapsules > 0 AND remainderOfCapsules <= 3");
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Map>>(
            future: getMedicinesWithLowCapsules(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text(S.of(context).allMedicinesHaveEnoughCapsules));
              } else {
                final medicines = snapshot.data!;
                return ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(medicine['medicineName']),
                          subtitle: Text(S.of(context).capsulesRemaining +
                              ' ${medicine['remainderOfCapsules']}'),
                          trailing: Icon(Icons.notification_important,
                              color: Colors.orange),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
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
