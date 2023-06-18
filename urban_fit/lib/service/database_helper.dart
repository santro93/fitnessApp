import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:urban_fit/assets/model/user_model.dart';
import 'package:urban_fit/model/food_tracker_model.dart';
import 'package:urban_fit/model/sleep_tracker_model.dart';
import 'package:urban_fit/model/water_tracker_model.dart';
import 'package:urban_fit/model/workout_tracker_model.dart';

class DataBaseHelper {
  static const _databaseName = 'Tracker.db';
  static const _databaseVersion = 1;
//
  static const userMasterTable = 'user_Master';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnMobile = 'mobile';
  static const columnEmail = 'email';
  static const columnPassword = 'password';
  //
  static const foodTrackerTable = 'food_Tracker';
  static const columnUserId = 'userid';
  static const columnFoodName = 'foodname';
  static const columnFoodUnit = 'foodunit';
  static const columnFoodDate = 'fooddate';
  static const columnFoodTime = 'foodtime';
//
  static const workoutTrackerTable = 'workout_Tracker';
  static const columnWorkoutName = 'workoutName';
  static const columnWorkoutUserId = 'workUserId';
  static const columnWorkoutDate = 'workoutDate';
  static const columnWorkoutTime = 'workoutTime';
  //
  static const waterTrackerTable = 'water_Tracker';
  static const columnWaterUserId = 'waterUserId';
  static const columnWaterGlass = 'waterGlass';
  static const columnWaterDate = 'waterDate';
  static const columnWaterTime = 'waterTime';
  //
  static const sleepTrackerTable = 'sleep_Tracker';
  static const columnSleepUserId = 'sleepUserId';
  static const columnSleepTime = 'sleepTime';
  static const columnSleepDate = 'sleepDate';
  static const columnWakeUpTime = 'wakeUpTime';
  //
  static Database? _database;
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $userMasterTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT,
            $columnMobile TEXT,
            $columnEmail TEXT,
            $columnPassword TEXT
          )
        ''');

        // Create Food tracker table             FOREIGN KEY (userid) REFERENCES user_master(id)
        await db.execute('''
          CREATE TABLE $foodTrackerTable(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnUserId INTEGER NOT NULL,
            $columnFoodName TEXT NOT NULL,
            $columnFoodUnit TEXT NOT NULL,
            $columnFoodDate TEXT NOT NULL,
            $columnFoodTime TEXT NOT NULL,
            FOREIGN KEY (userid) REFERENCES user_master(id)
          )
        ''');

        // Create workout tracker table   // $columnWorkoutUserId INTEGER NOT NULL,
        await db.execute('''
          CREATE TABLE $workoutTrackerTable (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $columnWorkoutUserId INTEGER NOT NULL,
          $columnWorkoutName TEXT NOT NULL,     
          $columnWorkoutTime TEXT NOT NULL,
          $columnWorkoutDate TEXT NOT NULL,
          FOREIGN KEY (workUserId) REFERENCES user_master(id)
      )
    ''');

        // Create watert racker table
        await db.execute('''
      CREATE TABLE $waterTrackerTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnWaterUserId INTEGER NOT NULL,
        $columnWaterGlass TEXT NOT NULL,
        $columnWaterDate TEXT NOT NULL,
        $columnWaterTime TEXT NOT NULL,
        FOREIGN KEY (waterUserId) REFERENCES user_master(id)
      )
    ''');

        // Create sleeptracker table    $columnTime TEXT NOT NULL
        await db.execute('''
      CREATE TABLE $sleepTrackerTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnSleepUserId INTEGER NOT NULL,
        $columnSleepTime TEXT NOT NULL,
        $columnWakeUpTime TEXT NOT NULL,
        $columnSleepDate TEXT NOT NULL,
        FOREIGN KEY (sleepUserId) REFERENCES user_master(id)
      )
    ''');
      },
    );
  }

/////////////////////////////////////////////////////////////////////////////////////////
  Future<int> createUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert(userMasterTable, user.toMap());
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query(userMasterTable);
    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  Future<UserModel?> getUserById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      userMasterTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result = await db.query(
      userMasterTable,
      where: '$columnEmail = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

///////////////////////////            food Tracker         /////////////////////////////
  Future<int> insertFoodTracker(FoodModel food) async {
    final db = await database;
    return await db.insert(foodTrackerTable, food.toMap());
  }

  Future<List<FoodModel>> getFoodTrackers(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      foodTrackerTable,
      where: 'userid = ?',
      whereArgs: [userId],
    );
    return result.map((map) => FoodModel.fromMap(map)).toList();
  }

  Future<int> deleteFoodTracker(int id) async {
    final db = await database;
    return await db.delete(
      foodTrackerTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateFoodTracker(FoodModel food) async {
    final db = await database;
    return await db.update(
      foodTrackerTable,
      food.toMap(),
      where: '$columnId = ?',
      whereArgs: [food.id],
    );
  }

//////////////////////// Workout Tracker   /////////////////////////////////////////////////////

  Future<int> insertWorkoutTrackerEntity(WorkoutModel workout) async {
    final db = await database;
    return await db.insert(workoutTrackerTable, workout.toMap());
  }

  Future<List<WorkoutModel>> queryAllWorkoutTrackerEntitis(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      workoutTrackerTable,
      where: 'workUserId = ?',
      whereArgs: [userId],
    );
    return result.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  Future<int> deleteWorkoutTrackerEntity(int id) async {
    final db = await database;
    return await db.delete(
      workoutTrackerTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateWorkoutTrackerEntity(WorkoutModel workout) async {
    final db = await database;
    return await db.update(
      workoutTrackerTable,
      workout.toMap(),
      where: '$columnId = ?',
      whereArgs: [workout.id],
    );
  }

  //////////////////////   'Water Tracker'    ////////////////////////////////////////////////

  Future<int> insertWaterTrackerEntity(WaterModel water) async {
    final db = await database;
    return await db.insert(waterTrackerTable, water.toMap());
  }

  Future<List<WaterModel>> queryAllWaterTrackerEntitis(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      waterTrackerTable,
      where: 'waterUserId = ?',
      whereArgs: [userId],
    );
    return result.map((map) => WaterModel.fromMap(map)).toList();
  }

  Future<int> deleteWaterTrackerEntity(int id) async {
    final db = await database;
    return await db.delete(
      waterTrackerTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateWaterTrackerEntity(WaterModel water) async {
    final db = await database;
    return await db.update(
      waterTrackerTable,
      water.toMap(),
      where: '$columnId = ?',
      whereArgs: [water.id],
    );
  }

  //////////////////         Sleep Tracker                    //////////////////////

  Future<int> insertSleepTracker(SleepModel sleep) async {
    final db = await database;
    return await db.insert(sleepTrackerTable, sleep.toMap());
  }

  Future<List<SleepModel>> queryAllSleepTrackerEntitis(int userId) async {
    final db = await instance.database;
    final result = await db.query(
      sleepTrackerTable,
      where: 'sleepUserId = ?',
      whereArgs: [userId],
    );
    return result.map((map) => SleepModel.fromMap(map)).toList();
  }

  Future<int> deleteSleepTrackerEntity(int id) async {
    final db = await database;
    return await db.delete(
      sleepTrackerTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateSleepTrackerEntity(SleepModel sleep) async {
    final db = await database;
    return await db.update(
      sleepTrackerTable,
      sleep.toMap(),
      where: '$columnId = ?',
      whereArgs: [sleep.id],
    );
  }
}
