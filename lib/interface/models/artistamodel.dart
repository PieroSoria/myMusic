class ArtistaM{
  int? id;
  String? artista;
  ArtistaM({this.id,this.artista});
  Map<String,dynamic> tomap() {
    return {
      'id':id,
      'artista': artista
    };
  }
  factory ArtistaM.fromMap(Map<String,dynamic> map) {
    return ArtistaM(
      id: map['id'] ?? 0,
      artista : map['artista'] ?? ''
    );
  }
}