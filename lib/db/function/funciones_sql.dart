import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_music/db/database.dart';
import 'package:my_music/interface/models/songs.dart';
import 'package:sqflite/sqflite.dart';

class FuncionesSQL {
  final dbcre = BaseSQL();

  // funciones generales

  Future<bool> capturarimagen(String id) async {
    Database? mydb = await dbcre.db;
    final picker = ImagePicker();
    XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
    int rep = await mydb!.rawUpdate(
        'UPDATE canciones SET imagen = ${imagen!.path} WHERE id = $id');
    return rep > 0;
  }

  Future<void> insertarcanciones(Cancion music) async {
    Database? mydb = await dbcre.db;
    final existingRecord = await mydb!.query(
      "canciones",
      where: 'id = ?',
      whereArgs: [music.id],
    );
    if (existingRecord.isEmpty) {
      await mydb.insert("canciones", music.tomap3());
    } else {
      return;
    }
  }

  Future<List<Map<String, dynamic>>> mostrarsongdatabase() async {
    Database? mydb = await dbcre.db;
    List<Map<String, dynamic>> data = await mydb!.query("canciones");
    return data;
  }

  // funciones de favoritos

  Future<List<Map<String, dynamic>>> cancionesfavoritas() async {
    Database? mydb = await dbcre.db;
    List<Map<String, dynamic>> data =
        await mydb!.rawQuery("SELECT * FROM canciones where favorito = 'true'");
    return data;
  }

  Future<bool> insertaroremoverfavoritos(String id) async {
    Database? mydb = await dbcre.db;
    final data = await mydb!.query("canciones",
        columns: ['favorito'], where: 'id = ?', whereArgs: [id]);
    if (data[0]['favorito'] == "true") {
      await mydb.rawUpdate(
          "UPDATE canciones SET favorito = ? WHERE id = ?", ['false', id]);
      return false;
    } else {
      await mydb.rawUpdate(
          "UPDATE canciones SET favorito = ? WHERE id = ?", ['true', id]);
      return true;
    }
  }

  Future<String> fillfavoritos(String id) async {
    Database? mydb = await dbcre.db;
    final data = await mydb!.query("canciones",
        columns: ['favorito'], where: 'id = ?', whereArgs: [id]);
    try {
      String result = data[0]['favorito'].toString();
      return result;
    } catch (e) {
      debugPrint("Error al actualizar la base de datos: $e");
      return e.toString();
    }
  }

  //funciones de playlist

  Future<List<Map<String, dynamic>>> cargarplaylist() async {
    Database? mydb = await dbcre.db;
    final data = await mydb!.query("listadeplaylist");
    return data;
  }

  Future<bool> crearplaylist(String nombre) async {
    Database? mydb = await dbcre.db;
    Digest id = sha256.convert(utf8.encode(nombre));
    var values = {'id': id, 'nombre': nombre};
    int rep = await mydb!.insert("listadeplaylist", values);
    return rep > 0;
  }

  Future<bool> removerplaylist(String id) async {
    Database? mydb = await dbcre.db;
    int rep =
        await mydb!.delete("listadeplaylist", where: "id = ?", whereArgs: [id]);
    return rep > 0;
  }
}
