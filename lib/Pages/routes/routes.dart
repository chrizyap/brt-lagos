import 'package:brtbus/Components/showRoute.dart';
import 'package:brtbus/Components/themes.dart';
import 'package:flutter/material.dart';
import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:brtbus/Components/busStops.dart';
import 'package:intl/intl.dart';

class RoutesPage extends StatefulWidget with NavigationStates {
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  DateTime now = DateTime.now();
  DateFormat dateFormatter = DateFormat('kk:mm');
  Map stopListMap = BusStops.busStopIndex;
  @override
  Widget build(BuildContext context) {
    // _getStops();
    return Stack(children: <Widget>[
      Container(color: Colors.white),
      Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black))),
              child: Text(
                'Route',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
            ),
            ShowRoute(
              route: true,
            )
          ],
        ),
      ),
    ]);
  }
}
