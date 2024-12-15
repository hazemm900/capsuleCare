
sealed class AddNewMedicineState {}

final class AddNewMedicineInitial extends AddNewMedicineState {}

final class EmitShouldRepeatFunc extends AddNewMedicineState {}

final class EmitSetAlarmFunc extends AddNewMedicineState {}
