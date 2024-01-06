import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/controller_settings.dart';

Future<void> cambiodefondo() async {
  final ImagePicker picker = ImagePicker();
  final controller = Get.put(ControllerSet());
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);
  if (imagen != null) {
    debugPrint("Ruta de la imagen: ${imagen.path}");
    pref.setString("pathimagen", imagen.path);
    controller.imagendefondo(imagen.path);
  } else {
    debugPrint("No se seleccionó ninguna imagen");
  }
}

Future<void> usarfondoguardado() async {
  final controller = Get.put(ControllerSet());
  SharedPreferences pref = await SharedPreferences.getInstance();
  String fondo = pref.getString("pathimagen") ?? "";
  controller.imagendefondo(fondo);
}
