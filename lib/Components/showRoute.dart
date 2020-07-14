import 'package:brtbus/Components/brttap.dart';
import 'package:brtbus/Components/themes.dart';
import 'package:brtbus/Components/tripDetails.dart';
import 'package:brtbus/Pages/map/polylines.dart';
import 'package:flutter/material.dart';
import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:brtbus/Components/busStops.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:supercharged/supercharged.dart';

class ShowRoute extends StatefulWidget {
  _ShowRoute createState() => _ShowRoute();
  bool route;
  bool trip;

  ShowRoute({route = false, trip = false}) {
    this.route = route;
    this.trip = trip;
  }
}

enum _BgProps { color1, color2 }

class _ShowRoute extends State<ShowRoute> {
  DateTime now = DateTime.now();
  DateFormat dateFormatter = DateFormat('kk:mm');
  Map stopListMap = BusStops.busStopIndex;

  Map stopListMap2 = Details.stopLists.asMap();

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_BgProps>()
      ..add(_BgProps.color1, Color(0xffD38312).tweenTo(Colors.red.shade900))
      ..add(_BgProps.color2, Color(0xffA83279).tweenTo(Colors.yellow.shade600));

    if (widget.route) {
      return Stack(children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: stopListMap.length,
                    itemBuilder: (BuildContext context, int index) {
                      Widget _setNode() {
                        if (stopListMap.keys.elementAt(index) ==
                            stopListMap.keys.elementAt(0)) {
                          return Container(
                            width: 50,
                            child: Column(
                              children: <Widget>[
                                Container(
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
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  width: 5,
                                  height: 60,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        } else if (stopListMap.keys.elementAt(index) ==
                            stopListMap.keys.elementAt(25)) {
                          return Container(
                            width: 50,
                            height: 80,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  width: 5,
                                  height: 20,
                                  color: Colors.black,
                                ),
                                Container(
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
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            width: 50,
                            height: 80,
                            child: Column(
                              children: <Widget>[
                                Container(
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
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  width: 5,
                                  height: 55,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          );
                        }
                      }

                      return BrtTap(
                        child: Container(
                          // color: Colors.red,
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.black,
                          //   ),
                          // ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[_setNode()],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    // alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${stopListMap.keys.elementAt(index)}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    height: 75,
                                    width:
                                        MediaQuery.of(context).size.width - 150,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    MirrorAnimation(
                                        tween: tween,
                                        duration: 3.seconds,
                                        builder: (context, child, value) {
                                          return Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      value
                                                          .get(_BgProps.color1),
                                                      value.get(_BgProps.color2)
                                                    ])),
                                          );
                                        }),
                                    SizedBox(height: 5),
                                    Text("CLEAR",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 8))
                                  ])
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]);
    }
    if (widget.trip) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          // controller: scrollcontroller,
          itemCount: stopListMap2.length + 1,
          itemBuilder: (BuildContext context, int index) {
            Widget _setNode() {
              if (stopListMap2[index] == stopListMap2.values.elementAt(1)) {
                return Container(
                  width: 50,
                  child: Column(
                    children: <Widget>[
                      Container(
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
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        width: 5,
                        height: 60,
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              } else if (stopListMap2[index - 1] == stopListMap2.values.last) {
                return Container(
                  width: 50,
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        width: 5,
                        height: 20,
                        color: Colors.black,
                      ),
                      Container(
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
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  width: 50,
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      Container(
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
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        width: 5,
                        height: 55,
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              }
            }

            if (index == 0) {
              return Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        timeTo['hours'] != 0
                                            ? Text(
                                                '${timeTo['hours']} hr',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20),
                                              )
                                            : Container(),
                                        Text(
                                          '${timeTo['minutes']} min',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: timeTo['hours'] != 0
                                                  ? 20
                                                  : 20),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
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
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          ('${Details.stops}'),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
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
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('₦300',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ))
                                      ],
                                    )),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
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
              return BrtTap(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[_setNode()],
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: <Widget>[
                        Container(
                          // alignment: Alignment.centerLeft,
                          // padding: EdgeInsets.all(20),
                          child: Text(
                            '${stopListMap2[index - 1]}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          height: 75,
                          width: MediaQuery.of(context).size.width - 150,
                          decoration: BoxDecoration(
                              // boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                              // color: Colors.red,

                              // borderRadius: BorderRadius.circular(12.0),
                              // shape: BoxShape.rectangle,
                              ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: Text(
                              '${dateFormatter.format(now.add(Duration(minutes: 5 * index)))}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(children: <Widget>[
                          MirrorAnimation(
                              tween: tween,
                              duration: 3.seconds,
                              builder: (context, child, value) {
                                return Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            value.get(_BgProps.color1),
                                            value.get(_BgProps.color2)
                                          ])),
                                );
                              }),
                          SizedBox(height: 5),
                          Text("CLEAR",
                              style: TextStyle(color: Colors.grey, fontSize: 8))
                        ])
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
    }

    return Center(child: Container(child: Text('Null')));
  }
}
