import 'package:brtbus/Components/Sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Components/themes.dart';

void main() {
  runApp(new MyApp());
}

//NOTE IF PERMISSION 4 LOCATION DENIED. SET ERROR HANDLER

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: SideBarLayout(),
        gradientBackground: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
            colors: [
              primaryBlue,
              secondaryBlue,
            ]),
        image: Image.asset(
          'images/app-icon.png',
        ),
        // title: Text(
        //   "BRT Lagos",
        //   style: TextStyle(
        //       color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        // ),
        photoSize: 100,
        loaderColor: Colors.transparent,

        // loaderColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
