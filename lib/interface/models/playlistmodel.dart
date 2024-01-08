class PlayList {
  String? id;
  String? nombre;
  PlayList({this.id, this.nombre});
  Map<String, dynamic> tomap() {
    return {'id': id, 'nombre': nombre};
  }

  factory PlayList.fromMap(Map<String, dynamic> map) {
    return PlayList(id: map['id'] ?? "", nombre: map['nombre'] ?? "");
  }
}
