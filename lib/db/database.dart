import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show join;

class BaseSQL {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await inicializacion();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> inicializacion() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "music.db");
    Database mydb = await openDatabase(path, onCreate: _createDB, version: 1);
    return mydb;
  }

  _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS listadeplaylist(id TEXT PRIMARY KEY, nombre TEXT, listmusic TEXT)");
    // await db.execute(
    //     "CREATE TABLE IF NOT EXISTS listademusic(id TEXT PRIMARY KEY, playlist TEXT, nombre TEXT)");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS canciones (id TEXT PRIMARY KEY,displayNameWOExt TEXT, displayName TEXT, artista TEXT, album TEXT,genero TEXT,datos TEXT,hora TEXT, fecha TEXT, ruta TEXT,uri TEXT,duration TEXT,imagen TEXT,favorito TEXT)");

    await db.execute(
        'CREATE TABLE IF NOT EXISTS playcountsong(displayNameWOExt TEXT, count TEXT)');
    debugPrint(
        "==================base de datos creada =======================");
  }
}
