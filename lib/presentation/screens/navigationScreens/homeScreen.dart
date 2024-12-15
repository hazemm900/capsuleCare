
import 'package:capsule_care/business_layer/add_new_medicine/add_new_medicine_cubit.dart';
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/addNewMedicineScreen.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/medicineSearchScreen.dart';
import 'package:capsule_care/presentation/widgets/medicineList.dart';
import 'package:capsule_care/presentation/widgets/myDrawer.dart';
import 'package:flutter/material.dart';

import '../../../core/base_widget/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This function will refresh the UI
  void refreshUI() {
    setState(() {
      // This will force the UI to rebuild and fetch the updated capsule count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const SafeArea(
      //   child: MyDrawer(),
      // ),
      // appBar: CutsomAppBar(title: S.of(context).appBarTitle,),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewMedicineScreen()));
        },
        child: const Icon(
          Icons.add,
          color: MyColors.myWhite,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: MedicineList(
                  onMedicineUpdate:
                      refreshUI, // Pass the callback to the MedicineList
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
