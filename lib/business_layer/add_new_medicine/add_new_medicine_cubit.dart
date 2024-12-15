import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/base_widget/custom_snack_bar.dart';
import '../../core/localization/generated/l10n.dart';
import '../../medicineDatabaseHelper.dart';
import '../../presentation/screens/navigationScreens/testNavigationBottom.dart';
import 'add_new_medicine_state.dart';

class AddNewMedicineCubit extends Cubit<AddNewMedicineState> {
  AddNewMedicineCubit() : super(AddNewMedicineInitial());

  static AddNewMedicineCubit get(context) => BlocProvider.of(context);

  SQDataBase sqDataBase = SQDataBase();
  TextEditingController medicineName = TextEditingController();
  TextEditingController totalNumberOfCapsules = TextEditingController();
  TextEditingController remainderOfCapsules = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  List<DateTime> alarms = []; // List to store alarm times
  bool shouldRepeat = false; // Track if the user wants the alarm to repeat

  addNewMedicineValidate(context) async {
    if (!formKey.currentState!.validate()) {
      showSnackBar(context, S.of(context).fillAllFields, "error");
      return;
    }
    final totalCapsules = int.tryParse(totalNumberOfCapsules.text);
    final remainderCapsules = int.tryParse(remainderOfCapsules.text);

    if (totalCapsules == null || remainderCapsules == null) {
      showSnackBar(context, S.of(context).fillAllFields, "error");
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
              body: '${S.of(context).timeToTakeMedicine}: ${medicineName.text}',
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
        showSnackBar(context, S.of(context).medicineAddedSuccessfully, "success");

        // Clear form fields after successful submission
        medicineName.clear();
        totalNumberOfCapsules.clear();
        remainderOfCapsules.clear();
        alarms.clear();
        shouldRepeat = false;

        // Navigate to the next screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const TestNavigationBottom(),
          ),
          (route) => false,
        );
      } else {
        showSnackBar(context, S.of(context).fillAllFields, "error");
      }
    } catch (error) {
      print(error.toString());
      showSnackBar(context, S.of(context).fillAllFields, "error");
    }
    emit(state);
  }

  shouldRepeatFunc(bool? value) {
    shouldRepeat = value ?? false;
    emit(EmitShouldRepeatFunc());
  }

  setAlarmFunc(context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final alarmTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      alarms.add(alarmTime);

      emit(EmitSetAlarmFunc());
    }
  }
  removeAlarmFunc(DateTime alarmTime) {
    alarms.remove(alarmTime);
    emit(EmitSetAlarmFunc());
  }
}
