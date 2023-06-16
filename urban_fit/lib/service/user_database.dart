
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:urban_fit/assets/model/user_model.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_master (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        mobile TEXT,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> createUser(UserModel user) async {
    final db = await instance.database;
    return await db.insert('user_master', user.toMap());
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await instance.database;
    final result = await db.query('user_master');
    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await instance.database;
    final result =
        await db.query('user_master', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty ? UserModel.fromMap(result.first) : null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;
    return await db.update(
      'user_master',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete(
      'user_master',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
