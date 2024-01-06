import 'package:flutter/material.dart';

import '../interface/models/tile_assets.dart';

class SideMenuTile extends StatelessWidget {
  final bool isActive;
  final String tile;
  final Icon? icon;
  final AssetImage? assetImage;
  final VoidCallback press;
  final Tileasset menu;
  const SideMenuTile({super.key, required this.isActive, required this.tile, this.icon, this.assetImage, required this.press, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(120, 50, 67, 110),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            ListTile(
              onTap: press,
              leading: menu.icon ??
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: menu.assetImage!)),
                  ),
              title: Text(
                menu.tile,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
