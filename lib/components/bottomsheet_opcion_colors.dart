import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_music/settings/Utils/palletcolors.dart';

class BottomSheetColor extends StatefulWidget {
  final BuildContext context;
  const BottomSheetColor({super.key, required this.context});

  @override
  State<BottomSheetColor> createState() => _BottomSheetColorState();
}

class _BottomSheetColorState extends State<BottomSheetColor> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  color: PalletColors.colormusic,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
