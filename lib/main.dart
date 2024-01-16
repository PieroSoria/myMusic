import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:permission_handler/permission_handler.dart';

import 'settings/routes/app_routes.dart';
import 'settings/routes/routes.dart';

late bool permiso;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  permiso = await estadodepermiso();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music',
      defaultTransition: Transition.fadeIn,
      initialRoute: permiso ? Routes.inicio : Routes.home,
      routes: approutes,
    );
  }
}

Future<bool> estadodepermiso() async {
  final status = await Permission.storage.status;
  final status2 = await Permission.audio.status;
  if (status.isGranted || status2.isGranted) {
    return true;
  } else if (status.isDenied || status2.isDenied) {
    return false;
  }
  return false;
}
