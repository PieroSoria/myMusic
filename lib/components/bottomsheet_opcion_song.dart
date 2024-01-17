import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/components/opcioniconbutton.dart';
import 'package:my_music/controller/player_controller.dart';

import 'package:my_music/interface/models/songs.dart';
import 'package:my_music/interface/page/playlist.dart';
import 'package:ringtone_set/ringtone_set.dart';
import 'package:share_plus/share_plus.dart';

class BotomSheetSong extends StatefulWidget {
  final int index;
  final Cancion cancion;
  final bool cambio;
  final String? idplaylist;
  const BotomSheetSong(
      {super.key,
      required this.cancion,
      required this.index,
      required this.cambio, this.idplaylist});

  @override
  State<BotomSheetSong> createState() => _BotomSheetSongState();
}

class _BotomSheetSongState extends State<BotomSheetSong> {
  final controller = Get.put(PlayerController());

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
              SizedBox(
                width: 280,
                child: Column(
                  children: [
                    Text(
                      widget.cancion.displayNameWOExt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OpcionIconButton(
                    onfunction: () {
                      Share.shareXFiles([XFile(widget.cancion.ruta)],
                          text: widget.cancion.displayNameWOExt);
                    },
                    titulo: "Compartir",
                    iconbtn: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  OpcionIconButton(
                    onfunction: () {
                      if (widget.cambio) {
                        controller.removercanciondelplaylist(widget.idplaylist!,widget.cancion.id);
                      } else {
                        Get.to(
                            () => PlayListMusic(
                                  seleccionl: false,
                                  idsong: widget.cancion.id,
                                ),
                            transition: Transition.fadeIn);
                      }
                    },
                    titulo: widget.cambio ? "Quitar del playlist" : "Agregar a",
                    iconbtn: const Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  OpcionIconButton(
                    onfunction: () {},
                    titulo: "Informacion",
                    iconbtn: const Icon(
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
                  OpcionIconButton(
                    onfunction: () {
                      controller.capturarimagen(
                          widget.cancion.id, widget.index);
                    },
                    titulo: "Diseño",
                    iconbtn: const Icon(
                      Icons.photo,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  OpcionIconButton(
                    onfunction: () {
                      RingtoneSet.setRingtoneFromFile(File(widget.cancion.ruta))
                          .then((value) => value
                              ? Get.snackbar("Exito",
                                  "Se cambio el tono de llamada a ${widget.cancion.displayName}",
                                  colorText: Colors.white)
                              : Get.snackbar("Opps!", "No se realizo el cambio",
                                  colorText: Colors.white));
                    },
                    titulo: "Tono de llamada",
                    iconbtn: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  OpcionIconButton(
                    onfunction: () {
                      controller.ocultarcancion(widget.cancion.ruta);
                    },
                    titulo: "Ocultar Cancion",
                    iconbtn: const Icon(
                      Icons.dnd_forwardslash_sharp,
                      color: Colors.white,
                      size: 36,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
