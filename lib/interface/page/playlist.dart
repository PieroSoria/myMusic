import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';

import '../../components/bottomsheet_opcion_playlist.dart';

class PlayListMusic extends StatefulWidget {
  const PlayListMusic({super.key});

  @override
  State<PlayListMusic> createState() => _PlayListMusicState();
}

class _PlayListMusicState extends State<PlayListMusic> {
  final listtext = TextEditingController();
  final controller = Get.put(PlayerController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: Text(
                      "Lista de Playlist",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                      controller: listtext,
                      decoration: InputDecoration(
                        labelText: "Ingrese una nueva lista",
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
                      onSubmitted: (value) {
                        controller.createplaylist(value);
                        setState(() {
                          listtext.text = "";
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 230,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(),
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.listplaylist.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text(
                          controller.listplaylist[index].nombre!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor:
                                    const Color.fromARGB(131, 82, 78, 78),
                                builder: (context) {
                                  return const BotomSheetPlaylist();
                                });
                          },
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
