import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../components/barmenu.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({super.key});

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  final controller = Get.put(PlayerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Text(
                "Favoritas",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 120,
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              child: FutureBuilder(
                future: controller.cancionesfavoritas(),
                builder: (context, snapshop) {
                  if (snapshop.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        "Cargando",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (snapshop.hasData || snapshop.error != null) {
                    return const Center(
                      child: Text(
                        "No se encontro ninguna cancion",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Obx(
                      () => ListView.builder(
                        itemCount: controller.favoritas.length,
                        itemBuilder: (context, index) {
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
                                String imagenPath =
                                    controller.favoritas[index].imagen;
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
                                    id: int.parse(
                                        controller.favoritas[index].id),
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
                                          image: AssetImage(
                                              'assets/image/shape.jpg'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }),
                              title: Text(
                                controller.favoritas[index].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                controller.favoritas[index].artista,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                controller.playsong(
                                    controller.favoritas[index].uri,
                                    index,
                                    controller.favoritas[index].id,
                                    controller
                                        .favoritas[index].displayNameWOExt,
                                    controller.favoritas);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
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
          ),
        ],
      ),
    );
  }
}
