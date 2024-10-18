// class MedicineAlarm{
//   final int id ;
//   final int medicineId ;
//   final String alarmTime  ;
//
//   MedicineAlarm(this.id, this.medicineId, this.alarmTime);
//
//
//
// }

class MedicineAlarm {
  final int id ;
  final int medicineId ;
  final String alarmTime  ;    // Flag to track if the medicine was taken

  MedicineAlarm({
    required this.id,
    required this.medicineId,
    required this.alarmTime,

  });

  // Convert MedicineAlarm to a map for saving to a database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicineId': medicineId,
      'alarmTime': alarmTime,

    };
  }

  // Create MedicineAlarm object from a map (e.g., when reading from a database)
  factory MedicineAlarm.fromMap(Map<dynamic, dynamic> map) {
    return MedicineAlarm(
      id: map['id'],
      medicineId: map['medicineId'],
      alarmTime: map['alarmTime'],

    );
  }
}
