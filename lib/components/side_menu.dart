import 'package:flutter/material.dart';

import '../interface/models/tile_assets.dart';
import 'side_menu_tile.dart';

class SideMenu extends StatefulWidget {
  final Widget currentWidget;
  final Function onSelectMenu;
  const SideMenu(
      {super.key, required this.currentWidget, required this.onSelectMenu});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Tileasset selectMenu = sideMenustile.first;
  Tileasset selectMenu2 = sideMenustile2.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 10, 7, 49),
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color.fromARGB(0, 10, 7, 49),
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 50,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/dort.png'),
                          fit: BoxFit.fill)),
                ),
                title: const Text(
                  "MUSIC",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: "Poppins"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 10, bottom: 16),
              child: Text(
                "Opciones".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white70, fontFamily: "Poppins"),
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  ...sideMenustile.map((tilemenu) => SideMenuTile(
                        isActive: selectMenu == tilemenu,
                        tile: tilemenu.tile,
                        icon: tilemenu.icon,
                        press: () {
                          setState(() {
                            selectMenu = tilemenu;
                            widget.onSelectMenu(tilemenu);
                          });
                        },
                        menu: tilemenu,
                      )),
                  ...sideMenustile2.map(
                    (tilemenu) => SideMenuTile(
                      isActive: selectMenu == tilemenu,
                      tile: tilemenu.tile,
                      icon: tilemenu.icon,
                      press: () {
                        setState(() {
                          selectMenu = tilemenu;
                          widget.onSelectMenu(tilemenu);
                        });
                      },
                      menu: tilemenu,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 24, top: 10, bottom: 16),
                child: SizedBox.shrink()),
            ...sideMenustile3.map(
              (e) => SideMenuTile(
                isActive: selectMenu == e,
                tile: e.tile,
                press: () {
                  setState(() {
                    selectMenu = e;
                    widget.onSelectMenu(e);
                  });
                },
                menu: e,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
