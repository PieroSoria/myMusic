import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:my_music/settings/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> concederpermiso() async {
    final controller = Get.put(PlayerController());
    var perm = await Permission.storage.request();
    var perm2 = await Permission.audio.request();
    if (perm.isGranted || perm2.isGranted) {
      controller.cargarcanciones().then((value) => value
          ? Get.toNamed(Routes.inicio)
          : Get.snackbar("Cargarndo", "Espere un momento",
              colorText: Colors.white));
    } else {
      Get.snackbar("Error", "No se concedio el permiso",
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white24,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "BIENVENIDO A NUESTRA APP!!",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Image.asset(
              "assets/image/dort.png",
              width: 200,
              height: 200,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'My Music',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: "Poppins"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Text(
                "Dale permiso a la app para buscar canciones en el dispositivo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: concederpermiso,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue.shade900,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20)),
                child: const Text(
                  "Dar Permiso",
                  style: TextStyle(
                      fontFamily: "Poppins", fontSize: 15, color: Colors.black),
                ))
          ],
        ));
  }
}
