import 'package:flutter/material.dart';
import 'package:brtbus/Components/Search/searchWidget.dart';
import 'package:brtbus/Components/Sidebar/sidebar.dart';
import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:brtbus/Components/googleMaps.dart';
import 'package:brtbus/Components/tripDetails.dart';

class MyHomePage extends StatefulWidget with NavigationStates {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    SearchWidget.controller =
        AnimationController(vsync: this, duration: _duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMaps(),
          SearchWidget(),
          SideBar(),
          TripDetails(),
          Center(
            child: Container(
              color: Colors.red,
              height: 20,
              width: 10,
            ),
          ),
        ],
      ),
    );
  }
}
