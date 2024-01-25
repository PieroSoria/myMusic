
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/controller_settings.dart';
import 'package:my_music/controller/player_controller.dart';

import '../../components/barmenu.dart';
import '../../components/songtype.dart';
import 'filtersearch.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final controller = Get.put(PlayerController());
  final controller2 = Get.put(ControllerSet());

  @override
  void initState() {
    controller2.iniciarstackmode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 36, 37, 82),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "My Music",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const FilterSongScreen(),
                  transition: Transition.rightToLeft);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              child: FutureBuilder(
                future: controller.mostrarcanciones(),
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
                          return SongType(index: index);
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
