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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      // controller: scrollcontroller,
                      itemCount: stopListMap.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        Widget _setNode() {
                          if (stopListMap[index] ==
                              stopListMap.values.elementAt(1)) {
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
                          } else if (stopListMap[index - 1] ==
                              stopListMap.values.last) {
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

                        if (index == 0) {
                          return Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    //Time
                                    Column(
                                      children: <Widget>[
                                        BrtTap(
                                          child: Container(
                                            padding: EdgeInsets.all(7),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Time",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    timeTo['hours'] != 0
                                                        ? Text(
                                                            '${timeTo['hours']} hr',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )
                                                        : Container(),
                                                    Text(
                                                      '${timeTo['minutes']} min',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              timeTo['hours'] !=
                                                                      0
                                                                  ? 20
                                                                  : 20),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: secondaryBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 2,
                                                    blurRadius: 1.5,
                                                    offset: Offset.zero),
                                              ],
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                  colors: [
                                                    primaryBlue,
                                                    secondaryBlue,
                                                    // Colors.white,
                                                  ],
                                                  stops: [
                                                    0.4,
                                                    1,
                                                  ]),
                                              // color: Colors.white,
                                            ),
                                            height: 90,
                                            width: 90,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Stops Column
                                    BrtTap(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(7),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Stops",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      ('${Details.stops}'),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: secondaryBlue,

                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 2,
                                                    blurRadius: 1.5,
                                                    offset: Offset.zero),
                                              ],

                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                  colors: [
                                                    primaryBlue,
                                                    secondaryBlue,
                                                    // Colors.white,
                                                  ],
                                                  stops: [
                                                    0.4,
                                                    1,
                                                  ]),
                                              // color: Colors.white,
                                            ),
                                            height: 90,
                                            width: 90,
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Fee Column
                                    BrtTap(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(7),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Fee",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('₦300',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          color: Colors.white,
                                                        ))
                                                  ],
                                                )),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: secondaryBlue,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 2,
                                                    blurRadius: 1.5,
                                                    offset: Offset.zero),
                                              ],
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomRight,
                                                  end: Alignment.topLeft,
                                                  colors: [
                                                    primaryBlue,
                                                    secondaryBlue,
                                                    // Colors.white,
                                                  ],
                                                  stops: [
                                                    0.4,
                                                    1,
                                                  ]),
                                            ),
                                            height: 90,
                                            width: 90,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(color: Colors.grey[400], thickness: 0.5)
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[_setNode()],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      '${stopListMap[index - 1]}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    height: 75,
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                    decoration: BoxDecoration(
                                      // boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(12.0),
                                      // shape: BoxShape.rectangle,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    width: 50,
                                    height: 75,
                                    // color: Colors.white,
                                    child: Text(
                                      '${dateFormatter.format(now.add(Duration(minutes: 5 * index)))}',
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      // boxShadow: [
                                      //   BoxShadow(color: Colors.grey, spreadRadius: 1)
                                      // ]
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
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
