import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/components/fondodeplay.dart';
import 'package:my_music/components/songtype.dart';
import 'package:my_music/controller/player_controller.dart';

class MusicReciente extends StatefulWidget {
  const MusicReciente({super.key});

  @override
  State<MusicReciente> createState() => _MusicRecienteState();
}

class _MusicRecienteState extends State<MusicReciente> {
  final controller = Get.put(PlayerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: FondoPlay(),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              child: FutureBuilder(
                future: controller.buscarporfechacanciones(),
                builder: (context, snapshop) {
                  if (snapshop.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text(
                        "Cargando",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    );
                  } else if (snapshop.hasData || snapshop.error != null) {
                    return const Center(
                      child: Text(
                        "No se encontro nada",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 20,
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
        ],
      ),
    );
  }
}
