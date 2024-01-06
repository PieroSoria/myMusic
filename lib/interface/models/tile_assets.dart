import 'package:flutter/material.dart';

class Tileasset {
  String tile;
  Icon? icon;
  AssetImage? assetImage;

  Tileasset({required this.tile, this.icon, this.assetImage});
}

List<Tileasset> sideMenustile = [
  Tileasset(
      tile: "Inicio",
      icon: const Icon(
        Icons.dashboard,
        color: Colors.white,
        size: 30,
      )),
  Tileasset(
      tile: "Álbumes",
      icon: const Icon(
        Icons.album,
        color: Colors.white,
        size: 30,
      )),
  Tileasset(
      tile: "Artistas",
      icon: const Icon(
        Icons.person,
        color: Colors.white,
        size: 30,
      )),
  Tileasset(
      tile: "Género",
      icon: null,
      assetImage: const AssetImage("assets/image/guitar.png"))
];

List<Tileasset> sideMenustile2 = [
  Tileasset(
      tile: "Listado",
      icon: const Icon(
        Icons.music_note_outlined,
        color: Colors.white,
        size: 30,
      )),
  Tileasset(
      tile: "Favoritos",
      icon: const Icon(
        Icons.star,
        color: Colors.white,
        size: 30,
      )),
  Tileasset(
      tile: "Más recientemente...",
      icon: const Icon(
        Icons.more_time,
        color: Colors.white,
        size: 30,
      )),
  Tileasset(
      tile: "Más reproducidas",
      icon: null,
      assetImage: const AssetImage("assets/image/reciente.png")),
];

List<Tileasset> sideMenustile3 = [
  Tileasset(
      tile: "Configuracion",
      icon: const Icon(
        Icons.settings,
        color: Colors.white,
        size: 30,
      ))
];
