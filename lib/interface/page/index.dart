import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_music/components/side_menu.dart';
import 'package:my_music/interface/page/album_artist_genero.dart';

import 'package:my_music/interface/page/musicrepro.dart';
import 'package:my_music/interface/page/playlist.dart';
import 'package:rive/rive.dart';

import '../../settings/Utils/fondo.dart';
import '../../settings/Utils/rive_utils.dart';
import '../../settings/config_app.dart';
import '../models/menu_btn.dart';
import '../models/tile_assets.dart';

import 'favorite_music.dart';
import 'music.dart';
import 'music_reciente.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  late Widget _currentWidget;
  late SMIBool isSideBarClose;
  bool isSideMenuClose = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late Tileasset selectMenu;
  late Tileasset selectMenu2;
  late Tileasset selectMenu3;

  @override
  void initState() {
    super.initState();
    _currentWidget = const Music();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void handleSwipeRightToLeft(DragUpdateDetails details) {
    if (details.primaryDelta! > 10) {
      if (isSideMenuClose) {
        isSideBarClose.value = false;
        _animationController.forward();
        setState(() {
          isSideMenuClose = false;
        });
        FocusScope.of(context).unfocus();
      }
    } else if (details.primaryDelta! < -10) {
      if (!isSideMenuClose) {
        isSideBarClose.value = true;
        _animationController.reverse();
        setState(() {
          isSideMenuClose = true;
        });
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: handleSwipeRightToLeft,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 10, 7, 49),
        body: Stack(
          children: [
            const Fondo(),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClose ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideMenu(
                currentWidget: _currentWidget,
                onSelectMenu: (menu) {
                  setState(() {
                    selectMenu = menu;
                    if (selectMenu == sideMenustile.first) {
                      _currentWidget = const Music();
                    } else if (selectMenu == sideMenustile[1]) {
                      _currentWidget = const ListAAG(listtype: 'Album',);
                    } else if (selectMenu == sideMenustile[2]) {
                      _currentWidget = const ListAAG(listtype: 'Artista',);
                    } else if (selectMenu == sideMenustile[3]) {
                      _currentWidget = const ListAAG(listtype: 'Genero',);
                    }
                  });
                  setState(() {
                    selectMenu2 = menu;
                    if (selectMenu2 == sideMenustile2.first) {
                      _currentWidget = const PlayListMusic();
                    } else if (selectMenu2 == sideMenustile2[1]) {
                      _currentWidget = const Favoritos();
                    } else if (selectMenu2 == sideMenustile2[2]) {
                      _currentWidget = const MusicReciente();
                    } else if (selectMenu2 == sideMenustile2[3]) {
                      _currentWidget = const MusicRepro();
                    }
                  });
                  setState(() {
                    selectMenu3 = menu;
                    if(selectMenu3 == sideMenustile3.first){
                      _currentWidget = const ConfigApp();
                    }
                  });
                  isSideBarClose.value = true;
                  isSideMenuClose = true;
                  _animationController.reverse();
                },
              ),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scalAnimation.value,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: IgnorePointer(
                        ignoring: !isSideMenuClose, child: _currentWidget),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isSideMenuClose ? 0 : 220,
              top: 16,
              child: MenuBtn(
                riveonInit: (artboard) {
                  StateMachineController controller = RiveUtils.getRiveController(
                      artboard,
                      stateMachineName: "State Machine");
                  isSideBarClose = controller.findSMI("isOpen") as SMIBool;
                  isSideBarClose.value = true;
                },
                press: () {
                  isSideBarClose.value = !isSideBarClose.value;
                  if (isSideMenuClose) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClose = isSideBarClose.value;
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
