import 'package:capsule_care/business_layer/add_new_medicine/add_new_medicine_cubit.dart';
import 'package:capsule_care/presentation/widgets/all_text_filed_in_add_new_medicine.dart';
import 'package:capsule_care/presentation/widgets/myElevationButton.dart';
import 'package:capsule_care/presentation/widgets/myWaveClipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_layer/add_new_medicine/add_new_medicine_state.dart';
import '../../../core/constants/my_colors.dart';
import '../../../core/localization/generated/l10n.dart';

class AddNewMedicineScreen extends StatelessWidget {
  const AddNewMedicineScreen({super.key});

  Widget buildRepeatAlarmCheckbox() {
    return BlocBuilder<AddNewMedicineCubit, AddNewMedicineState>(
      builder: (context, state) {
        return CheckboxListTile(
          title: Text(S.of(context).repeatAlarm),
          value: AddNewMedicineCubit.get(context).shouldRepeat,
          onChanged: (bool? value) {
            AddNewMedicineCubit.get(context).shouldRepeatFunc(value);
          },
        );
      },
    );
  }

  Widget buildSetAlarmButton() {
    return BlocBuilder<AddNewMedicineCubit, AddNewMedicineState>(
      builder: (context, state) {
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
                AddNewMedicineCubit.get(context).setAlarmFunc(context);
              },
              child: CustomElevatedButton.iconTextButtonChild(
                  Icons.alarm_add, S.of(context).setAlarm),
            ),
            SizedBox(height: 16.h),
            buildRepeatAlarmCheckbox(), // Add the checkbox here
            ...AddNewMedicineCubit.get(context).alarms.map((alarmTime) {
              return ListTile(
                title: Text(
                  '${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // setState(() {
                    //   AddNewMedicineCubit.get(context).   alarms.remove(alarmTime);
                    // });
                    AddNewMedicineCubit.get(context).removeAlarmFunc(alarmTime);
                  },
                ),
              );
            }).toList(),
            SizedBox(height: 64.h),
          ],
        );
      },
    );
  }
  // Method to show SnackBar
  Widget buildDoneButton() {
    return BlocBuilder<AddNewMedicineCubit, AddNewMedicineState>(
      builder: (context, state) {
        // var cubit = AddNewMedicineCubit.get(context);
        return CustomElevatedButton(
          child: CustomElevatedButton.iconTextButtonChild(
              Icons.done_all, S.of(context).done),
          onPressed: () {
            AddNewMedicineCubit.get(context).addNewMedicineValidate(context);
          },
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
            key: AddNewMedicineCubit.get(context).formKey,
            child: Column(
              children: [
                const MyWaveClipper(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      allTextFormFiledAddNewScreen(),
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
