import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FondoPlay extends StatefulWidget {
  const FondoPlay({super.key});

  @override
  State<FondoPlay> createState() => _FondoPlayState();
}

class _FondoPlayState extends State<FondoPlay> {
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Obx(
        () {
          final imagenPath = controller.currentimagen.value;
          if (imagenPath != "") {
            return Image.file(
              File(imagenPath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            );
          } else {
            return QueryArtworkWidget(
              id: controller.currentSongid.value,
              type: ArtworkType.AUDIO,
              artworkClipBehavior: Clip.none,
              artworkFit: BoxFit.fill,
              artworkWidth: double.infinity,
              artworkHeight: double.infinity,
              nullArtworkWidget: Image.asset(
                "assets/image/fondo.jpg",
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            );
          }
        },
      ),
    );
  }
}
