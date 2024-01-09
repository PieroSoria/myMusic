import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerSet extends GetxController {
  RxString imagendefondo = ''.obs;
  RxBool stackmode = false.obs;
  RxBool cargandosong = false.obs;

  void guardarstackmode(bool stack) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("stackmode", stack);
  }

  void togglestackmode() async {
    stackmode.value = !stackmode.value;
    guardarstackmode(stackmode.value);
  }

  void iniciarstackmode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    stackmode.value = pref.getBool("stackmode") ?? false;
  }

  Future<void> loadsong() async {
    final controller = Get.put(PlayerController());
    cargandosong(true);
    bool respon = await controller.cargarcanciones();
    if (respon) {
      cargandosong(false);
    }
  }
}
