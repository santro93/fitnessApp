import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:urban_fit/model/food_tracker_model.dart';
import 'package:urban_fit/model/sleep_tracker_model.dart';
import 'package:urban_fit/model/water_tracker_model.dart';
import 'package:urban_fit/model/workout_tracker_model.dart';

class DataBaseHelper {
  static const _databaseName = 'Tracker.db';
  static const _databaseVersion = 1;
  static const foodTrackerTable = 'food_Tracker';
  static const columnId = 'id';
  static const columnUserId = 'userid';
  static const columnFoodName = 'foodname';
  static const columnUnit = 'unit';
  static const columnDate = 'date';
  static const columnTime = 'time';
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
          CREATE TABLE user_master (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            mobile TEXT,
            email TEXT,
            password TEXT
          )
        ''');

        // Create Food tracker table             FOREIGN KEY (userid) REFERENCES user_master(id)
        await db.execute('''
          CREATE TABLE $foodTrackerTable(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnUserId TEXT NOT NULL,
            $columnFoodName TEXT NOT NULL,
            $columnUnit TEXT NOT NULL,
            $columnDate TEXT NOT NULL,
            $columnTime TEXT NOT NULL
        
          )
        ''');

        // Create workout tracker table   // $columnTime TEXT NOT NULL,
        await db.execute('''
          CREATE TABLE $workoutTrackerTable (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $columnWorkoutUserId TEXT NOT NULL,
          $columnWorkoutName TEXT NOT NULL,     
          $columnWorkoutTime TEXT NOT NULL,
          $columnWorkoutDate TEXT NOT NULL
     
      )
    ''');

        // Create watert racker table
        await db.execute('''
      CREATE TABLE $waterTrackerTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnWaterUserId TEXT NOT NULL,
        $columnWaterGlass TEXT NOT NULL,
        $columnWaterDate TEXT NOT NULL,
        $columnWaterTime TEXT NOT NULL
      )
    ''');

        // Create sleeptracker table    $columnTime TEXT NOT NULL
        await db.execute('''
      CREATE TABLE $sleepTrackerTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnSleepUserId TEXT NOT NULL,
        $columnSleepTime TEXT NOT NULL,
        $columnWakeUpTime TEXT NOT NULL,
        $columnSleepDate TEXT NOT NULL
      )
    ''');
        //
      },
    );
  }

///////////////////////////            food Tracker         /////////////////////////////
  Future<int> insertFoodTracker(FoodModel food) async {
    final db = await database;
    return await db.insert(foodTrackerTable, food.toMap());
  }

  Future<List<FoodModel>> getFoodTrackers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(foodTrackerTable); //foodTrackerTable
    return List.generate(maps.length, (i) {
      return FoodModel.fromMap(maps[i]);
    });
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

  Future<List<WorkoutModel>> queryAllWorkoutTrackerEntitis() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(workoutTrackerTable);
    return List.generate(maps.length, (i) {
      return WorkoutModel.fromMap(maps[i]);
    });
  }

  Future<int> deleteWorkoutTrackerEntity(int id) async {
    final db = await database;
    return await db.delete(
      workoutTrackerTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateWorkoutTrackerEntity(WorkoutModel water) async {
    final db = await database;
    return await db.update(
      waterTrackerTable,
      water.toMap(),
      where: '$columnId = ?',
      whereArgs: [water.id],
    );
  }

  //////////////////////   'Water Tracker'    ////////////////////////////////////////////////

  Future<int> insertWaterTrackerEntity(WaterModel water) async {
    final db = await database;
    return await db.insert(waterTrackerTable, water.toMap());
  }

  Future<List<WaterModel>> queryAllWaterTrackerEntitis() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(waterTrackerTable);
    return List.generate(maps.length, (i) {
      return WaterModel.fromMap(maps[i]);
    });
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

  Future<List<SleepModel>> queryAllSleepTrackerEntitis() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(sleepTrackerTable);
    return List.generate(maps.length, (i) {
      return SleepModel.fromMap(maps[i]);
    });
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
