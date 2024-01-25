import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'bottomsheet_opcion_song.dart';

class SongType extends StatefulWidget {
  final int index;
  const SongType({super.key, required this.index});

  @override
  State<SongType> createState() => _SongTypeState();
}

class _SongTypeState extends State<SongType> {
  final controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(73, 36, 37, 82),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: Obx(() {
          String imagenPath = controller.canciones[widget.index].imagen;
          if (imagenPath != "") {
            return Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: FileImage(File(imagenPath)), fit: BoxFit.fill),
              ),
            );
          } else {
            return QueryArtworkWidget(
              id: int.parse(
                controller.canciones[widget.index].id,
              ),
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
        }),
        title: Text(
          controller.canciones[widget.index].displayNameWOExt,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          controller.canciones[widget.index].artista,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                backgroundColor: const Color.fromARGB(0, 194, 193, 193),
                builder: (context) {
                  return BotomSheetSong(
                    cancion: controller.canciones[widget.index],
                    index: widget.index,
                    cambio: false,
                  );
                });
          },
          icon: const Icon(
            Icons.more_vert_outlined,
            color: Colors.white,
          ),
        ),
        onTap: () {
          controller.playsong(
            controller.canciones[widget.index].uri,
            widget.index,
            controller.canciones[widget.index].id,
            controller.canciones[widget.index].displayNameWOExt,
            controller.canciones,
          );
        },
      ),
    );
  }
}
