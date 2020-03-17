import 'package:brtbus/core/busStops.dart';
import 'package:brtbus/screens/settings.dart';
import 'package:brtbus/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'info.dart';
import 'about.dart';
import 'settings.dart';
import 'searchListView.dart';
import 'package:latlong/latlong.dart' as A;
import 'package:intl/intl.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:brtbus/Animation/FadeAnimation.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final A.Distance distance = new A.Distance();
  AnimationController _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DateTime now = DateTime.now();
  DateFormat dateFormatter = DateFormat('kk:mm');

  String kmString;
  _showSnackBar() {
    final snackBar = new SnackBar(
      content: new Text("Sorry, you can't choose the same bus stop!"),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        textColor: Colors.greenAccent,
        label: 'OK',
        onPressed: () {},
      ),
    );
    // Display snackbar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  List stopLists = [];

  var going = TextEditingController();
  var coming = TextEditingController();
  var textTouch = TextEditingController();

  GoogleMapController mapController;

  final Set<Marker> _markers = {};

  Marker _toMarker;
  Marker _fromMarker;

  final Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAVTGrgDL3-VpSWaEjdvgHDJxc_ffzWGmE";

  //static LatLng _tbsTerminal = LatLng(6.445721, 3.401200);
  //static LatLng _cmsTerminal = LatLng(6.451145, 3.389201);

  Map timeTo = {'hours': 5, 'minutes': 30};
  var stops = 0;
  var stopsString = '';

  static const LatLng _center = const LatLng(6.5244, 3.3792);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  MapType _currentMapType = MapType.normal;

//GET THE USERS LOCATION
  void getCurrentLocation() async {
    print("GET USER METHOD RUNNING =========");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(
        "the longitude is: ${position.longitude} and the latitude is: ${position.latitude} ");
  }

  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: primaryBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Map',
              style: TextStyle(
                  height: 4,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    //_lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    Map stopListMap = stopLists.asMap();

    // FirebaseAdMob.instance
    //     .initialize(appId: "ca-app-pub-3603864222235662~7855339836");
    // //     .then((response) {
    // //   myBanner
    // //     ..load()
    // //     ..show(
    // //       // anchorOffset: 0.0,
    // //       anchorType: AnchorType.bottom,
    // //     );
    // // });

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Colors.black,
        appBar: _getCustomAppBar(),

        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              // compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              polylines: Set<Polyline>.of(polylines.values),
              onCameraMove: _onCameraMove,
            ),
            Positioned(
              top: 50.6,
              right: 40.0,
              left: 40.0,
              child: FadeAnimation(
                  1.35,
                  Container(
                    height: 50.0,
                    width: 397.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: going,
                      onTap: () async {
                        dynamic result = await showSearch(
                            context: context, delegate: DataSearch());
                        going.text = result;
                        print('Where from: ${going.text}');
                        if (_fromMarker == null) {
                          whereFromSelected();
                        } else if (_fromMarker != null &&
                            _toMarker != null &&
                            BusStops.busStopMap[result] != coming.text) {
                          whereFromSelected();
                          _createRoute();
                        } else if (_fromMarker == _toMarker) {
                          _showSnackBar();
                          print('Snack bar displayed');
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 0),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue[900],
                          ),
                        ),
                        hintText: ("Where from?"),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                      ),
                    ),
                  )),
            ),
            Positioned(
              top: 100.0,
              right: 40.0,
              left: 40.0,
              child: FadeAnimation(
                  1.35,
                  Container(
                    height: 50.0,
                    width: 397.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 7.0),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ],
                      color: Colors.white,
                    ),
                    child: TextField(
                      enabled: _fromMarker != null,
                      controller: coming,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (query) {},
                      onTap: () async {
                        dynamic result = await showSearch(
                            context: context, delegate: DataSearch());
                        coming.text = going.text != result ? result : '';
                        print('Where to: ${coming.text}');

                        if (_fromMarker != null &&
                            BusStops.busStopMap[result] !=
                                _fromMarker.position) {
                          whereToSelected();
                          _createRoute();
                        } else {
                          _showSnackBar();
                          print("Snackbar Displayed");
                        }
                      },
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 0),
                          width: 10,
                          height: 10,
                          child: Icon(
                            MdiIcons.busSide,
                            color: Colors.blue[900],
                          ),
                        ),
                        hintText: "Where to?",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                      ),
                    ),
                  )),
            ),
            SlideTransition(
              position: _tween.animate(_controller),
              child: DraggableScrollableSheet(
                  // expand: true,
                  initialChildSize: 0.35,
                  minChildSize: 0.25,
                  maxChildSize: 1,
                  builder: (BuildContext context,
                      ScrollController scrollcontroller) {
                    return Container(
                      // height: 300,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),

                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 5,
                                  width: 50,
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: scrollcontroller,
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
                                                  Container(
                                                    padding: EdgeInsets.all(7),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          "Time",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            timeTo['hours'] != 0
                                                                ? Text(
                                                                    '${timeTo['hours']} hr',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            38),
                                                                  )
                                                                : Container(),
                                                            Text(
                                                              '${timeTo['minutes']} min',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: secondaryBlue,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            spreadRadius: 2,
                                                            blurRadius: 1.5,
                                                            offset:
                                                                Offset.zero),
                                                      ],
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomRight,
                                                          end:
                                                              Alignment.topLeft,
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
                                              //Stops Column
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(7),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          "Stops",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              ('$stops'),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 30,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: secondaryBlue,

                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            spreadRadius: 2,
                                                            blurRadius: 1.5,
                                                            offset:
                                                                Offset.zero),
                                                      ],

                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomRight,
                                                          end:
                                                              Alignment.topLeft,
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
                                              //Fee Column
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(7),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text(
                                                          "Fee",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text('₦300',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 22,
                                                                  color: Colors
                                                                      .white,
                                                                ))
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      color: secondaryBlue,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            spreadRadius: 2,
                                                            blurRadius: 1.5,
                                                            offset:
                                                                Offset.zero),
                                                      ],
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomRight,
                                                          end:
                                                              Alignment.topLeft,
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
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                            color: Colors.grey[400],
                                            thickness: 0.5)
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              height: 75,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              decoration: BoxDecoration(
                                                // boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
                                                color: Colors.white,

                                                borderRadius:
                                                    BorderRadius.circular(12.0),
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void whereFromSelected() {
    if (going.text != null) {
      _markers.remove(_fromMarker);
      polylines.clear();
      Marker newMarker = Marker(
          markerId: MarkerId(
            ('${going.text}'),
          ),
          position: BusStops.busStopMap[going.text],
          infoWindow: InfoWindow(title: ('${going.text}')),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
      _fromMarker = newMarker;
      _markers.add(_fromMarker);
    }
  }

  void whereToSelected() {
    if (coming.text != null) {
      _markers.remove(_toMarker);
      Marker newMarker = Marker(
          markerId: MarkerId(
            ('${coming.text}'),
          ),
          position: BusStops.busStopMap[coming.text],
          infoWindow: InfoWindow(
            title: ('${coming.text}'),
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
      _toMarker = newMarker;
      _markers.add(newMarker);
    }
  }

  void _createRoute() {
    polylineCoordinates.clear();
    polylines.clear();
    _getPolyline();
    calculateDistanceKM();
    calculateDistance();
    noOfStops();

    print('stopList: First  ${stopLists.first}');
    print('stopList: Last  ${stopLists.last}');

    // if (_fromMarker != null && _toMarker != null){

    // }
    if (_controller.isDismissed) {
      _controller.forward();
      print(_controller.status);
    } else if (_controller.isCompleted &&
        _fromMarker != null &&
        _toMarker != null) {
      _controller.forward();
      print(_controller.status);
    } else {
      _controller.reverse();
    }
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      width: 4,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
  }

  _getPolyline() async {
    List<PointLatLng> result1 = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        _fromMarker.position.latitude,
        _fromMarker.position.longitude,
        _toMarker.position.latitude,
        _toMarker.position.longitude);
    if (result1.isNotEmpty) {
      result1.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      _addPolyLine();
    }
  }

  void calculateDistance() {
    final double meter = distance(
      new A.LatLng(_toMarker.position.latitude, _toMarker.position.longitude),
      new A.LatLng(
          _fromMarker.position.latitude, _fromMarker.position.longitude),
    );
    print('$meter meters');
  }

  void calculateDistanceKM() {
    //setState(() {
    final double km = distance.as(
      A.LengthUnit.Kilometer,
      new A.LatLng(_toMarker.position.latitude, _toMarker.position.longitude),
      new A.LatLng(
          _fromMarker.position.latitude, _fromMarker.position.longitude),
    );
    double timeTaken = km / 35;
    timeTo = {
      'hours': timeTaken.floor(),
      'minutes': ((timeTaken % 1) * 60).ceil()
    };

    print('$km kilometers');
  }

  void noOfStops() {
    stopLists.clear();
    var x = BusStops.busStopIndex[_fromMarker.markerId.value];
    var y = BusStops.busStopIndex[_toMarker.markerId.value];

    // print('$x' '-' '$y');
    stops = (x - y);
    if (stops < 0) {
      stops = ((stops) - (2 * stops));
    }
    // print('$stops stops');

    int c = 0;
    for (int i = x; c <= stops; y > x ? i++ : i--) {
      c++;
      stopLists.add(BusStops.busStopIndex.keys.toList()[i - 1]);
    }
  }

  // Widget buildListView() {
  //   Map stopListMap = stopLists.asMap();
  //   return Container(
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       scrollDirection: Axis.vertical,
  //       itemCount: stopListMap.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         Widget _setNode() {
  //           if (stopListMap[index] == stopListMap.values.first) {
  //             return Container(
  //               alignment: Alignment.center,
  //               padding: EdgeInsets.all(5),
  //               width: 40,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 gradient: LinearGradient(
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topLeft,
  //                     colors: [
  //                       primaryBlue,
  //                       secondaryBlue,
  //                     ]),
  //               ),
  //             );
  //           } else if (stopListMap[index] == stopListMap.values.last) {
  //             return Container(
  //               alignment: Alignment.center,
  //               padding: EdgeInsets.all(5),
  //               width: 40,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 gradient: LinearGradient(
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topLeft,
  //                     colors: [
  //                       primaryBlue,
  //                       secondaryBlue,
  //                     ]),
  //               ),
  //             );
  //           } else {
  //             return Container(
  //               alignment: Alignment.center,
  //               padding: EdgeInsets.all(5),
  //               width: 25,
  //               height: 25,
  //               decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: secondaryBlue,
  //                         spreadRadius: 0.5,
  //                         offset: Offset(0.5, 1.0))
  //                   ],
  //                   color: secondaryBlue),
  //             );
  //           }
  //         }

  //         return Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: <Widget>[
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[_setNode()],
  //             ),
  //             Column(
  //               children: <Widget>[
  //                 Container(
  //                   alignment: Alignment.centerLeft,
  //                   padding: EdgeInsets.all(20),
  //                   child: Text(
  //                     '${stopListMap[index]}',
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.w500),
  //                   ),
  //                   height: 75,
  //                   width: MediaQuery.of(context).size.width - 150,
  //                   decoration: BoxDecoration(
  //                     // boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
  //                     color: Colors.white,

  //                     borderRadius: BorderRadius.circular(12.0),
  //                     // shape: BoxShape.rectangle,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Container(
  //                   alignment: Alignment.center,
  //                   padding: EdgeInsets.all(5),
  //                   width: 50,
  //                   height: 75,
  //                   // color: Colors.white,
  //                   child: Text(
  //                     '${dateFormatter.format(now.add(Duration(minutes: 5 * index)))}',
  //                     // textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: Colors.white,
  //                     // boxShadow: [
  //                     //   BoxShadow(color: Colors.grey, spreadRadius: 1)
  //                     // ]
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  //  Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = mapController;
  //   controller.animateCamera(CameraUpdate.newCameraPosition
  //   (CameraPosition(target: _toMarker.position, zoom: 11
  //    ),
  //   ),
  //   }
}

// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//   // birthday: DateTime.now(),
//   childDirected: false,
//   // designedForFamilies: false,
//   // gender:
//   //     MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );
// BannerAd myBanner = BannerAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: "ca-app-pub-3940256099942544/6300978111",
//   size: AdSize.smartBanner,
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );
