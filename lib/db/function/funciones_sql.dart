import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:my_music/db/database.dart';
import 'package:my_music/interface/models/playlistmodel.dart';
import 'package:my_music/interface/models/songs.dart';
import 'package:sqflite/sqflite.dart';

class FuncionesSQL {
  final dbcre = BaseSQL();

  // funciones generales

  Future<bool> capturarimagendatabase(String id, int index) async {
    Database? mydb = await dbcre.db;
    final controller = Get.put(PlayerController());
    final picker = ImagePicker();
    XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
    int rep = await mydb!.rawUpdate(
        "UPDATE canciones SET imagen = ? WHERE id = ?", [imagen!.path, id]);
    controller.currentimagen(imagen.path);
    controller.actualizarImagendelacancion(index, imagen.path);
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

  Future<bool> ocultarcanciondedb(String id) async {
    Database? mydb = await dbcre.db;
    int rep = await mydb!
        .rawUpdate("UPDATE canciones SET ver = ? WHERE id = ?", ['0', id]);
    return rep > 0;
  }

  Future<bool> sumarconteosong(String id) async {
    Database? mydb = await dbcre.db;
    final respon = await mydb!.query("canciones",
        columns: ['conteo'], where: 'id = ?', whereArgs: [id]);
    double result = respon[0]['conteo'] as double;
    double conteo = ++result;
    int rep1 = await mydb.rawUpdate(
        "UPDATE canciones SET conteo = ? WHERE id = ?", [conteo, id]);
    return rep1 > 0;
  }

  Future<List<Map<String, dynamic>>> mostrarsongdatabase() async {
    Database? mydb = await dbcre.db;
    List<Map<String, dynamic>> data =
        await mydb!.query("canciones", where: 'ver = ?', whereArgs: ['1']);
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
    final values =
        PlayList(id: id.toString(), nombre: nombre, listmusic: "", imagen: "");
    int rep = await mydb!.insert("listadeplaylist", values.tomap());
    return rep > 0;
  }

  Future<bool> removerplaylist(String id) async {
    Database? mydb = await dbcre.db;
    int rep =
        await mydb!.delete("listadeplaylist", where: "id = ?", whereArgs: [id]);
    return rep > 0;
  }

  Future<bool> renameplaylist(String id, String nombre) async {
    Database? mydb = await dbcre.db;
    int rep = await mydb!.rawUpdate(
        "UPDATE listadeplaylist SET nombre = ? WHERE id = ?", [nombre, id]);
    return rep > 0;
  }

  Future<bool> capturarimagenparaplaylist(String id, int index) async {
    Database? mydb = await dbcre.db;
    final controller = Get.put(PlayerController());
    final picker = ImagePicker();
    XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
    int rep = await mydb!.rawUpdate(
        "UPDATE listadeplaylist SET imagen = ? WHERE id = ?",
        [imagen!.path, id]);
    controller.actualizarimagendeplaylist(index, imagen.path);
    return rep > 0;
  }

  //funciones de musica de playlist

  Future<List<String>> musicadeplaylist(String id) async {
    Database? mydb = await dbcre.db;
    final data = await mydb!.query("listadeplaylist",
        columns: ['listmusic'], where: 'id = ?', whereArgs: [id]);
    List<String> respon = data[0]['listmusic'].toString().split('/');
    return respon;
  }

  Future<List<Map<String, dynamic>>> cargarmusicdelaplaylist(
      List<String> datos) async {
    Database? mydb = await dbcre.db;
    final data = await mydb!.query(
      "canciones",
      where: 'id IN (${List.filled(datos.length, '?').join(', ')})',
      whereArgs: datos,
    );
    return data;
  }

  Future<bool> insertarcancionenelplaylist(
      String idplaylist, String idsong) async {
    Database? mydb = await dbcre.db;
    final result = await mydb!.query("listadeplaylist",
        columns: ['listmusic'], where: 'id = ?', whereArgs: [idplaylist]);
    List<String> data = result[0]['listmusic'].toString().split('/');
    data.add(idsong);
    String newdata = data.join('/');
    int rep = await mydb.rawUpdate(
      "UPDATE listadeplaylist SET listmusic = ? WHERE id = ?",
      [newdata, idplaylist],
    );
    return rep > 0;
  }

  Future<bool> removercancionesenelplaylist(
      String idplaylist, String idsong) async {
    Database? mydb = await dbcre.db;
    List<String> result = await musicadeplaylist(idplaylist);
    bool respon = result.remove(idsong);
    if (respon) {
      String nuevaLista = result.join('/');
      await mydb!.rawUpdate(
          "UPDATE listadeplaylist SET listmusic = ? WHERE id = ?",
          [nuevaLista, idplaylist]);
      return true;
    } else {
      return false;
    }
  }

  //song type
  Future<List<Map<String, dynamic>>> cargarsongtype(
      String nombre, String type) async {
    Database? mydb = await dbcre.db;
    final data =
        await mydb!.query("canciones", where: '$type = ?', whereArgs: [nombre]);
    return data;
  }

  Future<List<Map<String, dynamic>>> filtersongdb(String nombre) async {
    Database? mydb = await dbcre.db;
      final data = await mydb!.query(
        "canciones",
        where:
            'displayNameWOExt LIKE ? OR artista LIKE ? OR album LIKE ? OR genero LIKE ?',
        whereArgs: List.generate(4, (index) => '%$nombre%'),
      );
      return data;
    
  }
}
