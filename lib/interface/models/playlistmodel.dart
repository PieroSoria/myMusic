class PlayList {
  String? id;
  String? nombre;
  String? listmusic;
  PlayList({this.id, this.nombre, this.listmusic});
  Map<String, dynamic> tomap() {
    return {'id': id, 'nombre': nombre, 'listmusic': listmusic};
  }

  factory PlayList.fromMap(Map<String, dynamic> map) {
    return PlayList(
        id: map['id'] ?? "",
        nombre: map['nombre'] ?? "",
        listmusic: map['listmusic'] ?? "");
  }
}
