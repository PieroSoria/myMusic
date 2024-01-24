import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';

import 'circule_songs.dart';

class Stack2 extends StatefulWidget {
  const Stack2({super.key});

  @override
  State<Stack2> createState() => _Stack2State();
}

class _Stack2State extends State<Stack2> {
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.duration.value,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: "Poppins",
                          fontSize: 18),
                    ),
                    const VerticalDivider(
                      color: Colors.white54,
                      thickness: 2,
                      width: 25,
                      indent: 2,
                      endIndent: 2,
                    ),
                    Text(
                      controller.position.value,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontFamily: "Poppins",
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const CirculoSong(),
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
                      )),
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
          ],
        ),
      ],
    );
  }
}
