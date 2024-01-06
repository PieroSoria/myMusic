import 'package:flutter/widgets.dart';

import '../../interface/page/home.dart';
import '../../interface/page/index.dart';

import 'routes.dart';

Map<String, Widget Function(BuildContext)> get approutes => {
      Routes.inicio: (_) => const Index(),
      Routes.home: (_) => const Home(),
      
    };
