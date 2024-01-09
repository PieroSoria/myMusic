import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/components/dialogoplaylist.dart';
import 'package:my_music/controller/player_controller.dart';

class BotomSheetPlaylist extends StatefulWidget {
  final String id;
  final String nombre;
  const BotomSheetPlaylist({super.key, required this.id, required this.nombre});

  @override
  State<BotomSheetPlaylist> createState() => _BotomSheetPlaylistState();
}

class _BotomSheetPlaylistState extends State<BotomSheetPlaylist> {
  final controller = Get.put(PlayerController());
  final edit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return DialogoPlaylist(id: widget.id);
                        });
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      Text(
                        "Editar nombre",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Icon(
                        Icons.play_circle,
                        color: Colors.white,
                      ),
                      Text(
                        "Reproducir ahora",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.removerplaylist(widget.id, widget.nombre);
                  },
                  child: const Column(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      Text(
                        "Eliminar playlist",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
