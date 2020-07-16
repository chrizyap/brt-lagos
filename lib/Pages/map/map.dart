import 'package:brtbus/Components/brtButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:brtbus/Pages/map/searchWidget.dart';
import 'package:brtbus/Components/Sidebar/sidebar.dart';
import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:brtbus/Pages/map/googleMaps.dart';
import 'package:brtbus/Components/tripDetails.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

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
          SearchWidget(onSelected: () {
            setState(() {});
            print('setting state');
          }),
          SideBar(),
          Visibility(
            visible: ButtonStream.isVisible,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Container(
                child: BrtButtonWidget(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 11, horizontal: 150),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TripDetails()));
                  },
                  text: 'Find Times and Prices',
                ),
              ),
            ),
          )

          // TripDetails(),
        ],
      ),
    );
  }
}

class ButtonStream {
  static bool isVisible = false;
}
