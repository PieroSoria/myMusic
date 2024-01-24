import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:my_music/settings/Utils/fondo.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../components/barmenu.dart';

class ListtemModel extends StatefulWidget {
  final String type;
  final String nombre;
 
  const ListtemModel(
      {super.key,
      required this.type,
      required this.nombre});

  @override
  State<ListtemModel> createState() => _ListtemModelState();
}

class _ListtemModelState extends State<ListtemModel> {
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Fondo(),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Text(
                "Canciones de ${widget.nombre}",
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
            left: 0,
            right: 0,
            child: SizedBox(
              child: FutureBuilder(
                future: controller.cargarsongtype(widget.nombre, widget.type),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        "Cargando Canciones del dispositivo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData || snapshot.error != null) {
                    return const Center(
                      child: Text(
                        "No se encontraron canciones en el dispositivo",
                        textAlign: TextAlign.center,
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
                        itemCount: controller.canciones.length,
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
                                    controller.canciones[index].imagen;
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
                                      controller.canciones[index].id,
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
                                controller.canciones[index].displayNameWOExt,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                controller.canciones[index].artista,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                controller.playsong(
                                  controller.canciones[index].uri,
                                  index,
                                  controller.canciones[index].id,
                                  controller.canciones[index].displayNameWOExt,
                                  controller.canciones,
                                );
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
