import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:my_music/db/function/funciones_sql.dart';
import 'package:my_music/interface/models/generomodel.dart';
import 'package:my_music/interface/models/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../interface/models/albummodel.dart';
import '../interface/models/artistamodel.dart';
import '../interface/models/playlistmodel.dart';

class PlayerController extends GetxController {
  final audioquery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  final funciones = FuncionesSQL();
  Rx<Uint8List?> artworkImage = Rx<Uint8List?>(null);

  RxList<Cancion> canciones = <Cancion>[].obs;
  RxBool isPlaying = false.obs;
  RxBool reproduccion = false.obs;
  RxInt playingindex = 0.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;

  var currentSongDisplayName = ''.obs;
  var currentSongartis = ''.obs;
  var currentSongid = 0.obs;
  var currentSongalbum = ''.obs;
  var currentSonggenero = ''.obs;
  var currentSongsize = ''.obs;
  var currentSonghora = ''.obs;
  var currentSongfecha = ''.obs;
  var currentSongruta = ''.obs;
  var currentSonguri = ''.obs;
  var currentduration = ''.obs;
  var currentimagen = ''.obs;
  var currentfavorito = false.obs;
  var isRepeatMode = false.obs;
  var isRandomMode = false.obs;

  RxList<Album> listalbum = <Album>[].obs;
  RxList<ArtistaM> listartist = <ArtistaM>[].obs;
  RxList<Genero> listgenero = <Genero>[].obs;
  RxList<PlayList> listplaylist = <PlayList>[].obs;

  @override
  void onInit() async {
    super.onInit();
    audioPlayer.currentIndexStream.listen((index) {
      if (index != null && index >= 0 && index < canciones.length) {
        actualcancion(canciones[index]);
      }
    });
    audioPlayer.playerStateStream.listen((playerState) {
      if (!audioPlayer.playing) {
        isPlaying(false);
      } else {
        isPlaying(true);
      }
    });
  }

  Future<bool> cargarcanciones() async {
    final datas = await audioquery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    final data = datas.where((e) => e.duration != null);
    try {
      for (var song in data) {
        final datamap = Cancion(
            id: song.id.toString(),
            displayNameWOExt: song.displayNameWOExt,
            displayName: song.displayName,
            artista: song.artist.toString(),
            album: song.album.toString(),
            genero: song.genre.toString(),
            datos: song.size.toString(),
            hora: song.duration.toString(),
            fecha: song.dateModified.toString(),
            ruta: song.data,
            uri: song.uri.toString(),
            imagen: '',
            favorito: 'false',
            ver: '1',
            conteo: 0);
        await funciones.insertarcanciones(datamap);
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> mostrarcanciones() async {
    funciones.mostrarsongdatabase().then((data) =>
        canciones.assignAll(data.map((e) => Cancion.fromMap(e)).toList()));
  }

  Future<void> ocultarcancion(String id) async {
    await funciones.ocultarcanciondedb(id).then((value) => value
        ? Get.snackbar("Exito", "La cancion se oculto correctamente",
            colorText: Colors.white)
        : Get.snackbar("Opps!!", "No se oculto la cancion",
            colorText: Colors.white));
    await mostrarcanciones();
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = formatDuration(d);
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = formatDuration(p);
      value.value = p.inSeconds.toDouble();
    });
  }

  String formatDuration(Duration? duration) {
    if (duration == null) {
      return '00:00';
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  void siguientecancion(int currentSongId) {
    var currentindex =
        canciones.indexWhere((song) => song.id == currentSongid.toString());
    var nextindex = currentindex + 1;
    if (nextindex >= canciones.length) {
      nextindex = 0;
    }
    var nextsong = canciones[nextindex];
    playsong(nextsong.uri, nextindex, nextsong.id, nextsong.displayNameWOExt,
        canciones);
  }

  void anteriorcancion(int currentsongid) {
    var actualindex =
        canciones.indexWhere((song) => song.id == currentsongid.toString());
    var anteriorindex = actualindex - 1;
    if (anteriorindex < 0) {
      anteriorindex = canciones.length - 1;
    }
    var anteriorcancion = canciones[anteriorindex];
    playsong(anteriorcancion.uri, anteriorindex, anteriorcancion.id,
        anteriorcancion.displayNameWOExt, canciones);
  }

  toggleRepeatMode() {
    isRepeatMode.value = !isRepeatMode.value;
    if (isRepeatMode.value) {
      Get.snackbar("Modo Repeticion", "Repeticion uno",
          colorText: Colors.white);
    } else {
      Get.snackbar("Modo Repeticion", "Repaticion todos",
          colorText: Colors.white);
    }
    audioPlayer.setLoopMode(isRepeatMode.value ? LoopMode.one : LoopMode.off);
  }

  void toggleRandomMode() {
    isRandomMode.value = !isRandomMode.value;
    if (isRandomMode.value) {
      audioPlayer.setShuffleModeEnabled(true);
      audioPlayer.shuffle();
      Get.snackbar("Modo Aleatorio", "Activado", colorText: Colors.white);
    } else {
      audioPlayer.setShuffleModeEnabled(false);
      Get.snackbar("Modo Aleatorio", "Desactivado", colorText: Colors.white);
    }
  }

  playsong(String? uri, index, id, titulo, List<Cancion> data) {
    actualcancion(data[index]);
    playingindex(index);
    try {
      audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: data
              .map((song) => AudioSource.uri(
                    Uri.parse(song.uri.toString()),
                    tag: MediaItem(
                      id: song.id.toString(),
                      title: song.displayNameWOExt.toString(),
                      artist: song.artista,
                      artUri: Uri.parse(song.uri.toString()),
                    ),
                  ))
              .toList(),
          shuffleOrder: DefaultShuffleOrder(),
        ),
        initialIndex: index,
      );
      audioPlayer.play();
      isPlaying(true);
      reproduccion(true);
      updatePosition();
      isfavoritos(id);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void actualcancion(Cancion song) {
    currentSongDisplayName.value = song.displayNameWOExt;
    currentSongartis.value = song.artista.toString();
    currentSongid.value = int.parse(song.id);
    currentSongalbum.value = song.album;
    currentSonggenero.value = song.genero;
    currentSongsize.value = song.datos.toString();
    currentSonghora.value = song.hora.toString();
    currentSongfecha.value = song.fecha.toString();
    currentSongruta.value = song.ruta;
    currentSonguri.value = song.uri.toString();
    currentimagen.value = song.imagen;
    currentfavorito.value = song.favorito == "true" ? true : false;
  }

  void togglePlayback() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
      isPlaying(false);
    } else {
      audioPlayer.play();
      isPlaying(true);
    }
  }

  Future<void> loadArtworkImage() async {
    final currentSongId = currentSongid.value;
    OnAudioQuery()
        .queryArtwork(currentSongId, ArtworkType.AUDIO)
        .then((artwork) => artworkImage.value = artwork);
  }

  void togglefavorites(id) async {
    bool result = await funciones.insertaroremoverfavoritos(id);
    if (result) {
      currentfavorito(true);
      Get.snackbar("Exito", "Se registro en la lista de canciones favoritas",
          colorText: Colors.white);
    } else {
      currentfavorito(false);
      Get.snackbar("Exito", "Se elimino de la lista de canciones favoritas",
          colorText: Colors.white);
    }
  }

  void isfavoritos(String id) async {
    String result = await funciones.fillfavoritos(id);
    debugPrint(result.toString());
    if (result == "true") {
      currentfavorito(true);
    } else {
      currentfavorito(false);
    }
  }

  void cancionesfavoritas() async {
    canciones.clear();
    funciones.cancionesfavoritas().then((data) =>
        canciones.assignAll(data.map((e) => Cancion.fromMap(e)).toList()));
  }

  Future<void> cargadealbumes() async {
    await audioquery
        .queryAlbums(
          sortType: AlbumSortType.ALBUM,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: null,
        )
        .then((data) => listalbum.assignAll(
            data.map((e) => Album(id: e.id, album: e.album)).toList()));
  }

  Future<void> cargardeartista() async {
    await audioquery
        .queryArtists(
          sortType: ArtistSortType.ARTIST,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: null,
        )
        .then((data) => listartist.assignAll(
            data.map((e) => ArtistaM(id: e.id, artista: e.artist)).toList()));
  }

  Future<void> cargadegenero() async {
    await audioquery
        .queryGenres(
          sortType: GenreSortType.GENRE,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: null,
        )
        .then((data) => listgenero.assignAll(
            data.map((e) => Genero(id: e.id, genero: e.genre)).toList()));
  }

  Future<void> cargarsongtype(String id, String type) async {
    if (type == "album") {
    } else if (type == "artista") {
    } else {}
  }

  Future<void> cargarlistadeplaylist() async {
    await funciones.cargarplaylist().then((data) =>
        listplaylist.assignAll(data.map((e) => PlayList.fromMap(e)).toList()));
  }

  Future<void> createplaylist(String name) async {
    await funciones.crearplaylist(name).then((value) => value
        ? Get.snackbar("Exito", "Se creo una lista de playlist",
            colorText: Colors.white)
        : Get.snackbar("Opps!!", "No se registro su playlist",
            colorText: Colors.white));
    await cargarlistadeplaylist();
  }

  Future<void> removerplaylist(String id, String nombreplaylist) async {
    await funciones.removerplaylist(id).then((value) => value
        ? Get.snackbar(
            "Exito", "Se elimino el playlist con el nombre de $nombreplaylist",
            colorText: Colors.white)
        : Get.snackbar(
            "Opps!", "No se pudo eliminar el playlist $nombreplaylist",
            colorText: Colors.white));
    await cargarlistadeplaylist();
  }

  Future<void> renameplaylist(String id, String newname) async {
    await funciones.renameplaylist(id, newname).then((value) => value
        ? Get.snackbar("Exito", "Se cambio el nombre a $newname",
            colorText: Colors.white)
        : Get.snackbar("Opp!", "Ocurrio un problema", colorText: Colors.white));
    await cargarlistadeplaylist();
  }

  Future<void> cargarplaylistselect(String id) async {
    canciones.clear();
    List<String> result = await funciones.musicadeplaylist(id);
    await funciones.cargarmusicdelaplaylist(result).then((data) =>
        canciones.assignAll(data.map((e) => Cancion.fromMap(e)).toList()));
  }

  Future<void> capturarimagen(String id, int currentsindex) async {
    await funciones.capturarimagendatabase(id, currentsindex).then((value) =>
        value
            ? Get.snackbar("Exito", "La imagen se guardo satisfactoriamente",
                colorText: Colors.white)
            : Get.snackbar("Opps!", "No se cargo ninguna imagen",
                colorText: Colors.white));
    // await mostrarcanciones();
  }

  Future<void> capturarimagenplaylist(String id, int currrentsindex) async {
    await funciones.capturarimagenparaplaylist(id, currrentsindex).then(
        (value) => value
            ? Get.snackbar("Exito", "La imagen se guardo satisfactoriamente",
                colorText: Colors.white)
            : Get.snackbar("Opps!", "No se cargo ninguna imagen",
                colorText: Colors.white));
  }

  Future<void> actualizarImagendelacancion(
      int index, String nuevaImagen) async {
    if (index >= 0 && index < canciones.length) {
      Cancion cancion = canciones[index];
      cancion.imagen = nuevaImagen;
      canciones[index] = cancion;
      canciones.refresh();
    }
  }

  Future<void> actualizarimagendeplaylist(int index, String nuevaimagen) async {
    if (index >= 0 && index < listplaylist.length) {
      PlayList playlist = listplaylist[index];
      playlist.imagen = nuevaimagen;
      listplaylist[index] = playlist;
      listplaylist.refresh();
    }
  }

  Future<void> insertcancionesplaylist(String idplaylist, String idsong) async {
    await funciones.insertarcancionenelplaylist(idplaylist, idsong).then(
        (value) => value
            ? Get.snackbar("Exito", "Se guardo correctamente",
                colorText: Colors.white)
            : Get.snackbar("Opps!", "Ocurrio un problema",
                colorText: Colors.white));
  }

  Future<void> removercanciondelplaylist(
      String idplaylist, String idsong) async {
    await funciones.removercancionesenelplaylist(idplaylist, idsong).then(
        (value) => value
            ? Get.snackbar("Exito", "Se quito la cancion del playlist",
                colorText: Colors.white)
            : Get.snackbar("Opps!", "Ocurrio un problema",
                colorText: Colors.white));
  }
}
