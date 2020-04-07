import 'package:brtbus/Pages/sidebar_layout.dart';
import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Pages/home.dart';

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
      home: SideBarLayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}
