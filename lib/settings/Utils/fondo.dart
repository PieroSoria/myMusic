import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/controller_settings.dart';

import '../function/funcionesdefondo.dart';

class Fondo extends StatefulWidget {
  const Fondo({super.key});

  @override
  State<Fondo> createState() => _FondoState();
}

class _FondoState extends State<Fondo> {
  final controller = Get.put(ControllerSet());

  @override
  void initState() {
    usarfondoguardado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final imagedefond = controller.imagendefondo.value;
      if (imagedefond != "") {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(
                File(controller.imagendefondo.value),
              ),
              fit: BoxFit.fill,
            ),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/fondo.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        );
      }
    });
  }
}
