import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:momentum/momentum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_plus/src/app/components/auth/home.controller.dart';
import 'package:weather_plus/src/app/components/favorite/favorite.controller.dart';
import 'package:weather_plus/src/app/components/location/index.dart';
import 'package:weather_plus/src/app/data/entities/location.entity.dart';
import 'package:weather_plus/src/app/data/services/weather_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.prod");
  Directory applicationsDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(LocationEntityAdapter());
  Hive.init(applicationsDocumentDirectory.path);
  runApp( momentum());
}

Momentum momentum() {
  return Momentum(
    controllers: [
      HomeController(),
      LocationController(),
      FavoriteController()
    ],
    services: [
      WeatherService()
    ],
    child: const WeatherApp(),
    // and more optional parameters here.
  );
}