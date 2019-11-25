

import 'package:flutter/material.dart';
import 'screens/home.dart';


void main() => runApp(MyApp());

  


//NOTE IF PERMISSION 4 LOCATION DENIED. SET ERROR HANDLER


  


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: MyHomePage(),

    ); 
  }
}