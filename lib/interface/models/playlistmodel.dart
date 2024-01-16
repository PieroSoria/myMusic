class PlayList {
  String? id;
  String? nombre;
  String? listmusic;
  String? imagen;
  PlayList({this.id, this.nombre, this.listmusic, this.imagen});
  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'nombre': nombre,
      'listmusic': listmusic,
      'imagen': imagen
    };
  }

  factory PlayList.fromMap(Map<String, dynamic> map) {
    return PlayList(
        id: map['id'] ?? "",
        nombre: map['nombre'] ?? "",
        listmusic: map['listmusic'] ?? "",
        imagen: map['imagen'] ?? "");
  }
}
