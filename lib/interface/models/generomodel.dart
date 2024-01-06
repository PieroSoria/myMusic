class Genero {
  int? id;
  String? genero;
  Genero({this.id, this.genero});
  Map<String, dynamic> tomap() {
    return {'id': id, 'genero': genero};
  }

  factory Genero.fromMap(Map<String, dynamic> map) {
    return Genero(
      id: map['id'] ?? 0,
      genero: map['genero'] ?? '',
    );
  }
}