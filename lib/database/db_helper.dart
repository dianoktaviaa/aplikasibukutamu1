import 'package:aplikasibukutamu/model/tamu.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper{
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableTamu';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnTelepon = 'telepon';
  final String columnAlamat = 'alamat';
  final String columnPesan = 'pesan';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async{
    if(_database != null){
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tamu.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async{
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT,"
        "$columnTelepon TEXT,"
        "$columnAlamat TEXT,"
        "$columnPesan TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveTamu(Tamu tamu) async{
    var dbClient = await _db;
    return await dbClient!.insert(tableName, tamu.toMap());
  }

  Future<List?> getAllTamu() async{
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNama,
      columnTelepon,
      columnAlamat,
      columnPesan
    ]);
    return result.toList();
  }

  Future<int?> updateTamu(Tamu tamu) async{
    var dbClient = await _db;
    return await dbClient!.update(tableName, tamu.toMap(), where: '$columnId=?', whereArgs: [tamu.id]);
  }

  Future<int?> deleteTamu(int id) async{
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}