class Cancion {
  String id;
  String displayNameWOExt;
  String displayName;
  String artista;
  String album;
  String genero;
  String datos;
  String hora;
  String fecha;
  String ruta;
  String uri;
  String imagen;
  String favorito;
  String ver;
  double conteo;

  Cancion(
      {required this.id,
      required this.displayNameWOExt,
      required this.displayName,
      required this.artista,
      required this.album,
      required this.genero,
      required this.datos,
      required this.hora,
      required this.fecha,
      required this.ruta,
      required this.uri,
      required this.imagen,
      required this.favorito,
      required this.ver,
      required this.conteo});
  Map<String, dynamic> tomap3() {
    return {
      'id': id,
      'displayNameWOExt': displayNameWOExt,
      'displayName': displayName,
      'artista': artista,
      'album': album,
      'genero': genero,
      'datos': datos,
      'hora': hora,
      'fecha': fecha,
      'ruta': ruta,
      'uri': uri,
      'imagen': imagen,
      'favorito': favorito,
      'ver': ver,
      'conteo': conteo
    };
  }

  factory Cancion.fromMap(Map<String, dynamic> map3) {
    return Cancion(
        id: map3['id'] ?? '',
        displayNameWOExt: map3['displayNameWOExt'] ?? '',
        displayName: map3['displayName'] ?? '',
        artista: map3['artista'] ?? '',
        album: map3['album'] ?? '',
        genero: map3['genero'] ?? '',
        datos: map3['datos'] ?? '',
        hora: map3['hora'] ?? '',
        fecha: map3['fecha'] ?? '',
        ruta: map3['ruta'] ?? '',
        uri: map3['uri'] ?? '',
        imagen: map3['imagen'] ?? '',
        favorito: map3['favorito'] ?? '',
        ver: map3['ver'] ?? '',
        conteo: map3['conteo'] ?? 0);
  }
}
