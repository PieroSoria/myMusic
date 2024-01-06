import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key,
    required this.press,
    required this.riveonInit,
  });
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "boton de menu",
      container: true,
      button: true,
      child: SafeArea(
        child: GestureDetector(
          onTap: press,
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: RiveAnimation.asset(
              "assets/icons/menu_button.riv",
              onInit: riveonInit,
            ),
          ),
        ),
      ),
    );
  }
}