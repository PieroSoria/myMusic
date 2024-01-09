import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';

import 'package:my_music/interface/models/songs.dart';
import 'package:ringtone_set/ringtone_set.dart';

class BotomSheetSong extends StatefulWidget {
  final Cancion cancion;
  const BotomSheetSong({super.key, required this.cancion});

  @override
  State<BotomSheetSong> createState() => _BotomSheetSongState();
}

class _BotomSheetSongState extends State<BotomSheetSong> {
  final controller = Get.put(PlayerController());

  Future<void> eliminarArchivo(String ruta) async {
    try {
      // Crea una instancia de File con la ruta del archivo
      File archivo = File(ruta);

      // Verifica si el archivo existe antes de intentar eliminarlo
      if (await archivo.exists()) {
        // Elimina el archivo
        await archivo.delete();
        debugPrint('Archivo eliminado correctamente.');
      } else {
        debugPrint('El archivo no existe.');
      }
    } catch (e) {
      debugPrint('Error al eliminar el archivo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 280,
                    child: Column(
                      children: [
                        Text(
                          widget.cancion.displayNameWOExt,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 16),
                        ),
                        Text(
                          widget.cancion.artista,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Column(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          "Compartir",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Column(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          "Agregar a",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Column(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          "Compartir",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      controller.capturarimagen(widget.cancion.id);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.photo,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          "Diseño",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      RingtoneSet.setRingtoneFromFile(File(widget.cancion.ruta))
                          .then((value) => value
                              ? Get.snackbar("Exito",
                                  "Se cambio el tono de llamada a ${widget.cancion.displayName}",
                                  colorText: Colors.white)
                              : Get.snackbar("Opps!", "No se realizo el cambio",
                                  colorText: Colors.white));
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          "Tono de Llamada",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      eliminarArchivo(widget.cancion.ruta);
                      
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 36,
                        ),
                        Text(
                          "Eliminar Cancion",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
