import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/player_controller.dart';

class DialogoPlaylist extends StatefulWidget {
  final String id;
  const DialogoPlaylist({super.key, required this.id});

  @override
  State<DialogoPlaylist> createState() => _DialogoPlaylistState();
}

class _DialogoPlaylistState extends State<DialogoPlaylist> {
  final controller = Get.put(PlayerController());
  final edit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(85, 95, 93, 93),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Editar el nombre del playlist",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                        controller: edit,
                        decoration: InputDecoration(
                          labelText: "Ingrese nombre",
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              controller.renameplaylist(widget.id, edit.text);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Editar",
                              style: TextStyle(color: Colors.black),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
