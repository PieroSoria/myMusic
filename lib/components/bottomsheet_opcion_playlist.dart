import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/components/dialogoplaylist.dart';
import 'package:my_music/components/opcioniconbutton.dart';
import 'package:my_music/controller/player_controller.dart';

class BotomSheetPlaylist extends StatefulWidget {
  final int index;
  const BotomSheetPlaylist({
    super.key,
    required this.index,
  });

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
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    controller.capturarimagenplaylist(controller.listplaylist[widget.index].id!,widget.index);
                  },
                  child: Container(
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                      image: DecorationImage(
                        image:
                            controller.listplaylist[widget.index].imagen != ""
                                ? FileImage(
                                    File(controller
                                        .listplaylist[widget.index].imagen!),
                                  ) as ImageProvider
                                : const AssetImage("assets/image/dort.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  controller.listplaylist[widget.index].nombre!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OpcionIconButton(
                      onfunction: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogoPlaylist(
                                id: controller.listplaylist[widget.index].id!);
                          },
                        );
                      },
                      titulo: "Editar nombre",
                      iconbtn: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    OpcionIconButton(
                      onfunction: () {},
                      titulo: "Reproducir ahora",
                      iconbtn: const Icon(
                        Icons.play_circle,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    OpcionIconButton(
                      onfunction: () {
                        controller.removerplaylist(
                            controller.listplaylist[widget.index].id!,
                            controller.listplaylist[widget.index].nombre!);
                      },
                      titulo: "Eliminar playlist",
                      iconbtn: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 36,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
