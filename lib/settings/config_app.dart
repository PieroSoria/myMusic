import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/components/bottomsheet_opcion_colors.dart';
import 'package:my_music/components/bottomsheet_opcion_stackmode.dart';
import 'package:my_music/controller/controller_settings.dart';
import 'package:my_music/settings/function/funcionesdefondo.dart';

class ConfigApp extends StatefulWidget {
  const ConfigApp({super.key});

  @override
  State<ConfigApp> createState() => _ConfigAppState();
}

class _ConfigAppState extends State<ConfigApp> {
  final controller = Get.put(ControllerSet());
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
                "Configuracion",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 30, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Column(
                children: [
                  Card(
                    color: const Color.fromARGB(0, 119, 117, 117),
                    child: Obx(
                      () => ListTile(
                        title: const Text(
                          "Buscar Canciones",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20,
                          ),
                        ),
                        subtitle: controller.cargandosong.value
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Escuchar",
                                style: TextStyle(
                                    fontFamily: "Poppins", color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                        onTap: () {
                          controller.loadsong();
                        },
                      ),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(0, 119, 117, 117),
                    child: Obx(
                      () => ListTile(
                        title: const Text(
                          "fondo de pantalla",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 20),
                        ),
                        subtitle: Text(
                          controller.imagendefondo.value != ""
                              ? "Ruta de la imagen: ${controller.imagendefondo.value}"
                              : "Ruta de la imagen:  Imagen por Defecto",
                          style: const TextStyle(
                              color: Colors.white, fontFamily: "Poppins"),
                        ),
                        onTap: () {
                          cambiodefondo();
                        },
                      ),
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(0, 119, 117, 117),
                    child: ListTile(
                      title: const Text(
                        "Estilo del PlaySong",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20),
                      ),
                      subtitle: const Text(
                        "Presione para ver los estilos",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor:
                              const Color.fromARGB(131, 82, 78, 78),
                          builder: (context) {
                            return BottomSheetOpcion(context: context);
                          },
                        );
                      },
                    ),
                  ),
                  Card(
                    color: const Color.fromARGB(0, 119, 117, 117),
                    child: ListTile(
                      title: const Text(
                        "Estilos de colores",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20),
                      ),
                      subtitle: const Text(
                        "Presione para ver los estilos",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Poppins"),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor:
                              const Color.fromARGB(131, 82, 78, 78),
                          builder: (context) {
                            return BottomSheetColor(context: context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
