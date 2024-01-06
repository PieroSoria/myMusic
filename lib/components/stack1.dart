import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';

class Stack1 extends StatefulWidget {
  const Stack1({super.key});

  @override
  State<Stack1> createState() => _Stack1State();
}

class _Stack1State extends State<Stack1> {
  final controller = Get.put(PlayerController());

  @override
  void initState() {
    controller.loadArtworkImage();
    ever(controller.currentSongid, (_) {
      controller.loadArtworkImage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(0),
            child: CircleAvatar(
              radius: 160,
              backgroundImage: controller.artworkImage.value != null
                  ? MemoryImage(controller.artworkImage.value!)
                  : controller.currentimagen.value != ""
                      ? FileImage(File(controller.currentimagen.value))
                          as ImageProvider<Object>?
                      : const AssetImage("assets/image/fondo.jpg"),
            ),
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              IconButton(
                onPressed: () {
                  controller
                      .togglefavorites(controller.currentSongid.toString());
                },
                icon: controller.currentfavorito.value
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 36,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 36,
                      ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  controller.currentSongDisplayName.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  controller.currentSongartis.value.toString(),
                  style: const TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: "Poppins"),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => Row(
              children: [
                Text(
                  controller.position.value,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    thumbColor: const Color.fromARGB(255, 87, 73, 119),
                    inactiveColor: Colors.white,
                    activeColor: const Color.fromARGB(255, 87, 73, 119),
                    min: const Duration(seconds: 0).inSeconds.toDouble(),
                    max: controller.max.value,
                    value: controller.value.value,
                    onChanged: (newValue) {
                      controller.changeDurationToSeconds(newValue.toInt());
                      newValue = newValue;
                    },
                  ),
                ),
                Text(
                  controller.duration.value,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
