import 'package:brtbus/Components/showRoute.dart';
import 'package:brtbus/Pages/map/searchWidget.dart';
import 'package:brtbus/Pages/map/polylines.dart';
import 'package:brtbus/Components/brttap.dart';
import 'package:brtbus/Components/busStops.dart';
import 'package:brtbus/Components/appBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'themes.dart';

class TripDetails extends StatelessWidget {
  // Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  DateTime now = DateTime.now();
  DateFormat dateFormatter = DateFormat('kk:mm');
  Map stopListMap = Details.stopLists.asMap();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 300,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          // vertical: 10,
        ),

        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                child: Column(children: <Widget>[
                  BackAppBar(),
                  ShowRoute(
                    trip: true,
                  ),
                ])),
          ],
        ),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
      ),
    );
  }
}

class Details {
  static var stops = 0;
  static var stopsString = '';

  static List stopLists = [];

  static void noOfStops() {
    stopLists.clear();
    var x = BusStops.busStopIndex[Polylines.fromMarker.markerId.value];
    var y = BusStops.busStopIndex[Polylines.toMarker.markerId.value];

    stops = (x - y);
    if (stops < 0) {
      stops = ((stops) - (2 * stops));
    }
    print('$stops stops');

    int c = 0;
    for (int i = x; c <= stops; y > x ? i++ : i--) {
      c++;
      stopLists.add(BusStops.busStopIndex.keys.toList()[i - 1]);
    }
  }
}
