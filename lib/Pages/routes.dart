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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.white,
              child: ListView.builder(
                // shrinkWrap: true,
                // controller: scrollcontroller,
                itemCount: stopListMap.length,
                itemBuilder: (BuildContext context, int index) {
                  Widget _setNode() {
                    if (stopListMap.keys.elementAt(index) ==
                        stopListMap.keys.elementAt(0)) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topLeft,
                              colors: [
                                primaryBlue,
                                secondaryBlue,
                              ]),
                        ),
                      );
                    } else if (stopListMap.keys.elementAt(index) ==
                        stopListMap.keys.elementAt(25)) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topLeft,
                              colors: [
                                primaryBlue,
                                secondaryBlue,
                              ]),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: secondaryBlue,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.5, 1.0))
                            ],
                            color: secondaryBlue),
                      );
                    }
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[_setNode()],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(20),
                            child: Text(
                              '${stopListMap.keys.elementAt(index)}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            height: 75,
                            width: MediaQuery.of(context).size.width - 150,
                            decoration: BoxDecoration(
                              // boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(12.0),
                              // shape: BoxShape.rectangle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

// void _getStops() {
//   BusStops.busStopIndex.keys.toList();
//   //

//   int c = 0;
//     for (int i = x; c <= BusStops.busStopIndex.le; y > x ? i++ : i--) {
//       c++;
//       stopLists.add(BusStops.busStopIndex.keys.toList());
//     }

//     print(BusStops.busStopIndex.keys.toList().
// }
