

class Album {
  String? album;
  int? id;
  Album({this.album, this.id});
  Map<String, dynamic> tomap() {
    return {'album': album, 'id': id};
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] ?? 0,
      album: map['album'] ?? '',
    );
  }
}
