import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:my_music/interface/page/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BarMenuMusic extends StatefulWidget {
  const BarMenuMusic({super.key});

  @override
  State<BarMenuMusic> createState() => _BarMenuMusicState();
}

class _BarMenuMusicState extends State<BarMenuMusic> {
  final controller = Get.put(PlayerController());
  @override
  void initState() {
    ever(controller.currentSongid, (_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Get.to(() => const Player(), transition: Transition.downToUp);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 16,
                sigmaY: 16,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(
                      () {
                        String imagenPath = controller.currentimagen.value;
                        if (imagenPath != "") {
                          return Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  image: FileImage(File(imagenPath)),
                                  fit: BoxFit.fill),
                            ),
                          );
                        } else {
                          return QueryArtworkWidget(
                            id: controller.currentSongid.value,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.fill,
                            artworkBorder: BorderRadius.circular(6),
                            artworkHeight: 48,
                            artworkWidth: 48,
                            nullArtworkWidget: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: const DecorationImage(
                                  image: AssetImage('assets/image/shape.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Obx(
                      () => SizedBox(
                        width: 180,
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.currentSongDisplayName.value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: "Poppins", color: Colors.white),
                            ),
                            Text(
                              controller.currentSongartis.value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: "Poppins", color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => IconButton(
                            onPressed: () {
                              controller.togglePlayback();
                            },
                            icon: controller.isPlaying.value
                                ? Transform.scale(
                                    scale: 2,
                                    child: const Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 2,
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.siguientecancion(
                                controller.currentSongid.value);
                          },
                          icon: Transform.scale(
                            scale: 1.5,
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
