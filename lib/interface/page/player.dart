import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/components/stack2.dart';
import 'package:my_music/controller/controller_settings.dart';
import 'package:my_music/controller/player_controller.dart';

import '../../components/fondodeplay.dart';
import '../../components/opcion_button_player.dart';
import '../../components/stack1.dart';
import '../../settings/Utils/palletcolors.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final controller = Get.put(PlayerController());
  final controller2 = Get.put(ControllerSet());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: FondoPlay(),
        ),
        Align(
          alignment: Alignment.center,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! > 10) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                      PalletColors.colormusic,
                      PalletColors.colormusic,
                    ],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(0, 194, 193, 193),
                                    builder: (context) {
                                      return Container();
                                    });
                              },
                              icon: const Icon(
                                Icons.more_vert_outlined,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      controller2.stackmode.value
                          ? const Stack2()
                          : const Stack1(),
                      const OpcionButton()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
