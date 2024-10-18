import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQDataBase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intiaDataBase();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> intiaDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "medicine.db");
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 9, // Ensure you're using the latest version with required tables
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 8) { // Use a new version number like 8
      // Create a new table without the columns you want to remove
      await db.execute('''
    CREATE TABLE MedicineDetails_new (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      medicineName TEXT NOT NULL,
      totalNumberOfCapsules INTEGER NOT NULL,
      remainderOfCapsules INTEGER NOT NULL,
      isRecurring INTEGER
    )
    ''');

      // Copy data from the old table to the new one (excluding the columns to remove)
      await db.execute('''
    INSERT INTO MedicineDetails_new (id, medicineName, totalNumberOfCapsules, remainderOfCapsules, isRecurring)
    SELECT id, medicineName, totalNumberOfCapsules, remainderOfCapsules, isRecurring FROM MedicineDetails;
    ''');

      // Drop the old table
      await db.execute('DROP TABLE MedicineDetails');

      // Rename the new table to the original name
      await db.execute('ALTER TABLE MedicineDetails_new RENAME TO MedicineDetails');
    }

    // Existing upgrade logic
    if (oldVersion < 5) {
      await db.execute('''
    CREATE TABLE MedicineAlarms (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      medicineId INTEGER NOT NULL,
      alarmTime TEXT NOT NULL,
      FOREIGN KEY (medicineId) REFERENCES MedicineDetails(id) ON DELETE CASCADE
    )
    ''');
    }

    print("DATABASE UPGRADED >>>>>>>>>>>>>>>>>>>>>");
  }

  Future<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
    CREATE TABLE MedicineDetails (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      medicineName TEXT NOT NULL,
      totalNumberOfCapsules INTEGER NOT NULL,
      remainderOfCapsules INTEGER NOT NULL,
      isRecurring INTEGER
    )
    ''');

    batch.execute('''
    CREATE TABLE MedicineAlarms (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      medicineId INTEGER NOT NULL,
      alarmTime TEXT NOT NULL,
      FOREIGN KEY (medicineId) REFERENCES MedicineDetails(id) ON DELETE CASCADE
    )
    ''');

    await batch.commit();
    print("DATABASE UPGRADED >>>>>>>>>>>>>>>>>>>>>");
  }

  // Method to decrement the capsule count by 1
// Method to decrement the capsule count by 1 based on alarmId
  Future<void> decrementCapsuleCount(int alarmId) async {
    final db = await this.db;

    // Get the medicineId associated with the given alarmId
    List<Map> alarmResult = await db!.query(
      'MedicineAlarms',
      columns: ['medicineId'],
      where: 'id = ?',
      whereArgs: [alarmId],
    );

    if (alarmResult.isNotEmpty) {
      int medicineId = alarmResult.first['medicineId'] as int;

      // Get the current capsule count for the associated medicine
      List<Map> medicineResult = await db.query(
        'MedicineDetails',
        columns: ['remainderOfCapsules'],
        where: 'id = ?',
        whereArgs: [medicineId],
      );

      if (medicineResult.isNotEmpty) {
        int remainingCapsules =
            medicineResult.first['remainderOfCapsules'] as int;

        if (remainingCapsules > 0) {
          // Decrease the count by 1
          remainingCapsules -= 1;

          // Update the database with the new capsule count
          await db.update(
            'MedicineDetails',
            {'remainderOfCapsules': remainingCapsules},
            where: 'id = ?',
            whereArgs: [medicineId],
          );
        }
      }
    }
  }

  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // CRUD operations for MedicineDetails

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<void> deleteMyDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "medicine.db");
    await deleteDatabase(path);
  }

  Future<List<Map>> readDataSQFLite(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  Future<int> insertDataSQFLite(
      String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  Future<int> updateDataSQFLite(
      String table, Map<String, Object?> values, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: myWhere);
    return response;
  }

  Future<int> deleteDataSQFLite(String table, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: myWhere);
    return response;
  }

  // CRUD operations for MedicineAlarms

  Future<int> insertAlarm(Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert('MedicineAlarms', values);
    return response;
  }

  Future<List<Map>> getAlarmsForMedicine(int medicineId) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query('MedicineAlarms',
        where: 'medicineId = ?', whereArgs: [medicineId]);
    return response;
  }

  Future<int> updateAlarm(int id, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!
        .update('MedicineAlarms', values, where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<int> deleteAlarm(int id) async {
    Database? mydb = await db;
    int response =
        await mydb!.delete('MedicineAlarms', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<int> deleteAllAlarmsForMedicine(int medicineId) async {
    Database? mydb = await db;
    int response = await mydb!.delete('MedicineAlarms',
        where: 'medicineId = ?', whereArgs: [medicineId]);
    return response;
  }
}
