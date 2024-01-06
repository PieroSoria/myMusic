import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/controller_settings.dart';

class BottomSheetOpcion extends StatefulWidget {
  final BuildContext context;
  const BottomSheetOpcion({super.key, required this.context});

  @override
  State<BottomSheetOpcion> createState() => _BottomSheetOpcionState();
}

class _BottomSheetOpcionState extends State<BottomSheetOpcion> {
  final controller = Get.put(ControllerSet());
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Seleccione un Modo",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Poppins", fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Stack Mode 1",
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.togglestackmode();
                          Navigator.of(context).pop();
                        },
                        child: Obx(
                          () => Container(
                            width: 150,
                            height: 300,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: controller.stackmode.value == false
                                  ? Border.all(
                                      color: Colors.deepPurpleAccent,
                                      width: 2,
                                    )
                                  : const Border(),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/image/stack1mode.jpg",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Stack Mode 2",
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.togglestackmode();
                          Navigator.of(context).pop();
                        },
                        child: Obx(
                          () => Container(
                            width: 150,
                            height: 300,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: controller.stackmode.value
                                  ? Border.all(
                                      color: Colors.deepPurpleAccent,
                                      width: 2,
                                    )
                                  : const Border(),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/image/stack2mode.jpg",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
