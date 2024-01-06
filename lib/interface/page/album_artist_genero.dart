import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../../components/barmenu.dart';
import 'listtemmodel.dart';

class ListAAG extends StatefulWidget {
  final String listtype;
  const ListAAG({super.key, required this.listtype});

  @override
  State<ListAAG> createState() => _ListAAGState();
}

class _ListAAGState extends State<ListAAG> {
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Text(
                "Lista de ${widget.listtype}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(),
              child: FutureBuilder(
                future: widget.listtype == "Album"
                    ? controller.cargadealbumes()
                    : widget.listtype == "Artista"
                        ? controller.cargardeartista()
                        : controller.cargadegenero(),
                builder: (context, snapshot) {
                  return Obx(
                    () => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: widget.listtype == "album"
                          ? controller.listalbum.length
                          : widget.listtype == "artista"
                              ? controller.listartist.length
                              : controller.listgenero.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            if (widget.listtype == "album") {
                              controller.cargarsongtype(
                                  controller.listalbum[index].id.toString(),
                                  widget.listtype);
                              Get.to(
                                  () => ListtemModel(
                                      type: widget.listtype,
                                      nombre:
                                          controller.listalbum[index].album!),
                                  transition: Transition.downToUp);
                            } else if (widget.listtype == "artista") {
                              controller.cargarsongtype(
                                  controller.listartist[index].id.toString(),
                                  widget.listtype);
                              Get.to(
                                  () => ListtemModel(
                                      type: widget.listtype,
                                      nombre: controller
                                          .listartist[index].artista!),
                                  transition: Transition.downToUp);
                            } else {
                              controller.cargarsongtype(
                                  controller.listgenero[index].id.toString(),
                                  widget.listtype);
                              Get.to(
                                  () => ListtemModel(
                                      type: widget.listtype,
                                      nombre:
                                          controller.listgenero[index].genero!),
                                  transition: Transition.downToUp);
                            }
                          },
                          child: SizedBox(
                            child: Stack(
                              children: [
                                QueryArtworkWidget(
                                  id: widget.listtype == "album"
                                      ? controller.listalbum[index].id!
                                      : widget.listtype == "artista"
                                          ? controller.listartist[index].id!
                                          : controller.listgenero[index].id!,
                                  type: widget.listtype == "album"
                                      ? ArtworkType.ALBUM
                                      : widget.listtype == "artista"
                                          ? ArtworkType.ARTIST
                                          : ArtworkType.GENRE,
                                  artworkClipBehavior: Clip.hardEdge,
                                  artworkWidth: double.infinity,
                                  artworkHeight: double.infinity,
                                  artworkFit: BoxFit.fill,
                                  artworkBorder: BorderRadius.circular(20),
                                  nullArtworkWidget: Image.asset(
                                    "assets/image/dort.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                          bottom: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      widget.listtype == "album"
                                          ? controller.listalbum[index].album!
                                          : widget.listtype == "artista"
                                              ? controller
                                                  .listartist[index].artista!
                                              : controller
                                                  .listgenero[index].genero!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child:
                  controller.reproduccion.value ? const BarMenuMusic() : null,
            ),
          )
        ],
      ),
    );
  }
}
