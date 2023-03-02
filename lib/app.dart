
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_plus/src/ui/pages/home/main_page.dart';


class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'Weather',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              inputDecorationTheme: const InputDecorationTheme(
                //contentPadding: EdgeInsets.all(25.0),
                contentPadding: EdgeInsets.fromLTRB(14, 16, 14, 16),
              ),
              useMaterial3: true,
              fontFamily: 'Poppins',
            ),
            home: child);
      },
      child: const MainPage(),
    );
  }
}