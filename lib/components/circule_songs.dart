import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music/controller/player_controller.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CirculoSong extends StatefulWidget {
  const CirculoSong({super.key});

  @override
  State<CirculoSong> createState() => _CirculoSongState();
}

class _CirculoSongState extends State<CirculoSong> {
  final controller = Get.put(PlayerController());
  @override
  void initState() {
    controller.loadArtworkImage();
    ever(controller.currentSongid, (_) {
      controller.loadArtworkImage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SleekCircularSlider(
        initialValue: controller.value.value,
        min: 0.0,
        max: controller.max.value,
        onChange: (d) {
          controller.changeDurationToSeconds(d.toInt());
          d = d;
        },
       
        innerWidget: (percentage) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Obx(
              () => CircleAvatar(
                backgroundImage: controller.currentimagen.value != ""
                    ? FileImage(File(controller.currentimagen.value))
                    : controller.artworkImage.value != null
                        ? MemoryImage(controller.artworkImage.value!)
                            as ImageProvider<Object>?
                        : const AssetImage("assets/image/fondo.jpg"),
              ),
            ),
          );
        },
        appearance: CircularSliderAppearance(
          //330
          size: MediaQuery.of(context).size.height / 3,
          angleRange: 300,
          startAngle: 300,
          customColors: CustomSliderColors(
              progressBarColor: const Color.fromARGB(255, 121, 74, 232),
              dotColor: Colors.deepPurple.shade300,
              trackColor: Colors.grey.withOpacity(.4)),
          customWidths: CustomSliderWidths(
            trackWidth: 6,
            handlerSize: 8,
            progressBarWidth: 7,
          ),
        ),
      ),
    );
  }
}
