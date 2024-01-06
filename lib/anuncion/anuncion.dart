import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Anuncio extends StatefulWidget {
  const Anuncio({super.key});

  @override
  State<Anuncio> createState() => _AnuncioState();
}

class _AnuncioState extends State<Anuncio> {
  BannerAd? bannerAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-9560499727609076/4928124202'
      : 'ca-app-pub-9560499727609076/4928124202';
  bool isLoaded = false;
  final AdSize adSize = const AdSize(width: 350, height: 70);

  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
          setState(() {
            isLoaded = false;
          });
        },
      ),
    )..load();
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoaded
          ? Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 51, 51, 87).withOpacity(1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: bannerAd!.size.width.toDouble(),
                height: bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: bannerAd!),
              ),
            )
          : const SizedBox(height: 0, width: 0),
    );
  }
}
