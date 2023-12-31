import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  Future<int?> newScanRaw(ScanModel newScan) async {
    final id    = newScan.id;
    final tipo  = newScan.tipo;
    final valor = newScan.valor;

    final db = await database;
    final args = [id, tipo, valor];

    final res = await db?.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES(?, ? ,?)
    ''', args);

    return res;
  }

  Future<int?> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db?.insert('Scans', newScan.toJson());
    return res;
  }

  Future<ScanModel?> getScanById(int id) async{
    final db = await database;
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res!.isNotEmpty
      ? ScanModel.fromJson(res.first)
      : null;
  }

  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db?.query('Scans');

    return res!.isNotEmpty
      ? res.map((s) => ScanModel.fromJson(s)).toList()
      : [];
  }

  Future<List<ScanModel>?> getScansByType(String type) async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT * FROM Scans WHERE tipo = ?
    ''', [type]);

    return res!.isNotEmpty
      ? res.map((s) => ScanModel.fromJson(s)).toList()
      : [];
  }

  Future<int?> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db?.update('Scans', newScan.toJson(), where: 'id=?', whereArgs: [newScan.id]);
    return res;
  }

  Future<int?> deleteScan(int id) async {
    final db = await database;
    final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int?> deleteAllScans() async {
    final db = await database;
    final res = await db?.delete('Scans');
    return res;
  }
}
