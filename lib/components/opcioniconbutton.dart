import 'package:flutter/material.dart';

class OpcionIconButton extends StatefulWidget {
  final Function() onfunction;
  final String titulo;
  final Icon iconbtn;
  const OpcionIconButton(
      {super.key,
      required this.onfunction,
      required this.titulo,
      required this.iconbtn});

  @override
  State<OpcionIconButton> createState() => _OpcionIconButtonState();
}

class _OpcionIconButtonState extends State<OpcionIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onfunction,
      child: Column(
        children: [
          widget.iconbtn,
          SizedBox(
            width: 100,
            child: Text(
              widget.titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
