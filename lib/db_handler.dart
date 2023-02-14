import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:zikirmatik_2023/model.dart';

class DbHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Dhikrs.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  _createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Dhikrs(id INTEGER PRIMARY KEY AUTOINCREMENT, dhikrName TEXT NOT NULL, dhikrCount integer NOT NULL, dhikrImame TEXT NOT NULL, dhikrPronunication TEXT NOT NULL, dhikrMeaning TEXT NOT NULL, dateAndTime TEXT NOT NULL)");
  }

  Future<DhikrModel> insert(DhikrModel dhikrModel) async {
    var dbClient = await db;
    await dbClient?.insert('Dhikrs', dhikrModel.toMap());
    return dhikrModel;
  }

  Future<List<DhikrModel>> getDataList() async {
    await db;
    final List<Map<String, Object?>> queryResult =
        await _db!.rawQuery('SELECT * FROM Dhikrs');
    return queryResult.map((e) => DhikrModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('Dhikrs', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(int id,int count) async {
    var dbClient = await db;
    return await dbClient!.rawUpdate(
        'UPDATE Dhikrs SET dhikrCount = $count WHERE id = $id',);
  }
}
