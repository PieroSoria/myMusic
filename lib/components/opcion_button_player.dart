import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';

class OpcionButton extends StatefulWidget {
  const OpcionButton({super.key});

  @override
  State<OpcionButton> createState() => _OpcionButtonState();
}

class _OpcionButtonState extends State<OpcionButton> {
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Transform.scale(
            scale: 2.5,
            child: IconButton(
              onPressed: () {
                controller.toggleRandomMode();
              },
              icon: controller.isRandomMode.value
                  ? const Icon(
                      Icons.shuffle,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.keyboard_double_arrow_right_rounded,
                      color: Colors.white,
                    ),
            ),
          ),
          Transform.scale(
            scale: 2.5,
            child: IconButton(
              onPressed: () {
                controller.anteriorcancion(controller.currentSongid.value);
              },
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: const Color.fromRGBO(65, 82, 114, 0.589),
              child: Transform.scale(
                scale: 2,
                child: IconButton(
                  onPressed: () {
                    controller.togglePlayback();
                  },
                  icon: controller.isPlaying.value
                      ? const Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 36,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 36,
                        ),
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: 2.5,
            child: IconButton(
              onPressed: () {
                controller.siguientecancion(controller.currentSongid.value);
              },
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            ),
          ),
          Transform.scale(
            scale: 2,
            child: IconButton(
              onPressed: () {
                controller.toggleRepeatMode();
              },
              icon: controller.isRepeatMode.value
                  ? const Icon(
                      Icons.repeat_one,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.repeat,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
