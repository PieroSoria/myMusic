import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:my_music/settings/Utils/fondo.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../components/barmenu.dart';
import '../../components/bottomsheet_opcion_song.dart';
import 'index.dart';

class FilterSongScreen extends StatefulWidget {
  const FilterSongScreen({super.key});

  @override
  State<FilterSongScreen> createState() => _FilterSongScreenState();
}

class _FilterSongScreenState extends State<FilterSongScreen> {
  final searchtext = TextEditingController();
  final controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Get.to(() => const Index(), transition: Transition.rightToLeft);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Fondo(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 120,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const Index(),
                              transition: Transition.rightToLeft);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                        controller: searchtext,
                        onChanged: (value) {
                          setState(() {
                            value = searchtext.text;
                            controller.filtersong(search: searchtext.text);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Buscar la cancion ",
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  future: controller.filtersong(search: searchtext.text),
                  builder: (context, snapshop) {
                    if (snapshop.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text(
                          "Cargando",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      );
                    } else if (snapshop.hasData || snapshop.error != null) {
                      return const Center(
                          child: Text(
                        "no se encontro ninguna cancion",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ));
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
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                trailing: IconButton(
                                  onPressed: () async {
                                    final canciones =
                                        await controller.mostrarsong();
                                    // ignore: use_build_context_synchronously
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          0, 194, 193, 193),
                                      builder: (context) {
                                        final selectedSong =
                                            controller.canciones[index];
                                        final selectedSongIndex =
                                            canciones.indexWhere((song) =>
                                                song.displayNameWOExt ==
                                                selectedSong.displayNameWOExt);
                                        return BotomSheetSong(
                                          cancion: controller.canciones[index],
                                          index: selectedSongIndex,
                                          cambio: false,
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () async {
                                  final cancions =
                                      await controller.mostrarsong();
                                  final selectedSong =
                                      controller.cancions[index];
                                  final selectedSongIndex =
                                      cancions.indexWhere((song) =>
                                          song.displayNameWOExt ==
                                          selectedSong.displayNameWOExt);

                                  controller.playsong(
                                    selectedSong.uri,
                                    selectedSongIndex,
                                    selectedSong.id,
                                    selectedSong.displayNameWOExt,
                                    cancions,
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
      ),
    );
  }
}
