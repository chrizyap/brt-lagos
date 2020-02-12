import 'package:brtbus/core/busStops.dart';
import 'package:brtbus/screens/settings.dart';
import 'package:brtbus/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'info.dart';
import 'about.dart';
import 'settings.dart';
import 'listView.dart';
import 'package:latlong/latlong.dart' as A;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:brtbus/Animation/FadeAnimation.dart';
import 'package:simple_animations/simple_animations.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final A.Distance distance = new A.Distance();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
    if ([CardStates.fullVisible, CardStates.halfVisible]
        .contains(_cardStates)) {
      setState(() {
        _cardStates = CardStates.hidden;
      });
    }
  }

  CardStates _cardStates = CardStates.hidden;
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
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     secondaryBlue,
          //     primaryBlue,
          //   ],
          //   // stops: [
          //   //   0.12,
          //   //   0.7
          //   // ]
          // ),
          color: primaryBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // IconButton(
            //     icon: Icon(Icons.menu), color: Colors.white, onPressed: () {}),

            Text(
              'Map',
              style: TextStyle(
                  height: 5,
                  fontSize: 19,
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
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Colors.black,
        appBar: _getCustomAppBar(),

        // drawer: new Drawer(
        //   child: new ListView(
        //     children: <Widget>[
        //       new ListTile(
        //           title: new Text("Map"),
        //           leading: Icon(Icons.map),
        //           trailing: Icon(Icons.arrow_upward),
        //           onTap: () {
        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) => MyHomePage()));
        //           }),
        //       new ListTile(
        //           title: new Text("Info"),
        //           leading: Icon(Icons.contacts),
        //           trailing: Icon(Icons.arrow_right),
        //           onTap: () {
        //             //Navigator.of(context).pop();
        //             Navigator.of(context).push(new MaterialPageRoute(
        //                 builder: (BuildContext context) =>
        //                     new InfoPage("Info")));
        //           }),
        //       Divider(
        //         color: Colors.black,
        //       ),
        //       new ListTile(
        //           title: new Text("Settings"),
        //           leading: Icon(Icons.settings),
        //           trailing: Icon(Icons.arrow_right),
        //           onTap: () {
        //             Navigator.of(context).push(new MaterialPageRoute(
        //                 builder: (BuildContext context) =>
        //                     new SettingsPage("Settings")));
        //           }),
        //       new ListTile(
        //           title: new Text("About"),
        //           leading: Icon(Icons.help),
        //           trailing: Icon(Icons.arrow_right),
        //           onTap: () {
        //             Navigator.of(context).push(new MaterialPageRoute(
        //                 builder: (BuildContext context) =>
        //                     new InfoPage("About")));
        //           }),
        //     ],
        //   ),
        // ),
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
            AnimatedPositioned(
              duration: Duration(milliseconds: 600),
              top: _cardStates == CardStates.halfVisible
                  ? MediaQuery.of(context).size.height - 280
                  : _cardStates == CardStates.fullVisible
                      ? MediaQuery.of(context).size.height - 450
                      : MediaQuery.of(context).size.height,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _cardStates = _cardStates == CardStates.fullVisible
                        ? CardStates.halfVisible
                        : CardStates.fullVisible;
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                style: TextStyle(fontSize: 38),
                                              )
                                            : Container(),
                                        Text(
                                          '${timeTo['minutes']} min',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: timeTo['hours'] != 0
                                                  ? 20
                                                  : 25),
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
                                      color: secondaryBlue,
                                      spreadRadius: 1,
                                      blurRadius: 1.5,
                                    ),
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
                                height: 100,
                                width: 100,
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
                                          ('$stops'),
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
                                      color: secondaryBlue,
                                      spreadRadius: 1,
                                      blurRadius: 1.5,
                                    ),
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
                                height: 100,
                                width: 100,
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
                                              fontSize: 28,
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
                                      color: secondaryBlue,
                                      spreadRadius: 1,
                                      blurRadius: 1.5,
                                    ),
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
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      buildListView()
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                    // gradient: LinearGradient(
                    //     begin: Alignment.bottomCenter,
                    //     end: Alignment.topCenter,
                    //     colors: [
                    //       primaryBlue,
                    //       secondaryBlue,
                    //       Colors.transparent,
                    //     ],
                    //     stops: [
                    //       0.3,
                    //       0.6,
                    //       0.1
                    //     ]),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    // boxShadow: [
                    //   BoxShadow(
                    //       // color: Colors.blue[900],
                    //       offset: Offset(1.0, 5.0),
                    //       blurRadius: 10,
                    //       spreadRadius: 1)
                    // ],
                  ),
                ),
              ),
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
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.grey,
                      //       offset: Offset(1.0, 5.0),
                      //       blurRadius: 7,
                      //       spreadRadius: 1)
                      // ],
                    ),
                    child: TextField(
                      controller: going,
                      onTap: () async {
                        dynamic result = await showSearch(
                            context: context, delegate: DataSearch());

                        going.text = result;

                        print('Where from: $result');
                        void whereFromSelected() {
                          setState(() {
                            if (_fromMarker != null) {
                              _markers.remove(_fromMarker);
                            }
                            if ((_fromMarker != null &&
                                    BusStops.busStopMap[result] !=
                                        _toMarker.position) ||
                                _fromMarker == null) {
                              Marker newMarker = Marker(
                                  // This marker id can be anything that uniquely identifies each marker.
                                  markerId: MarkerId(
                                    ('$result'),
                                  ),
                                  //make position respond to user selection
                                  position: BusStops.busStopMap[result],
                                  infoWindow: InfoWindow(title: ('$result')

                                      //snippet: '5 Star Rating',
                                      ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueBlue));
                              _fromMarker = newMarker;
                              _markers.add(newMarker);
                            } else {
                              _showSnackBar();
                              print("Snackbar Displayed");
                              //Add toast to show user you can't do this.

                            }
                            if (_fromMarker != null && _toMarker != null) {
                              _getPolyline();
                              calculateDistanceKM();
                              calculateDistance();
                            }
                          });
                        }

                        whereFromSelected();
                        //polylineCoordinates.clear();
                      },

                      cursorColor: Colors.black,
                      //controller: appState.locationController,
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
                        print('Where to: $result');
                        void whereToSelected() {
                          setState(() {
                            if (_toMarker != null) {
                              _markers.remove(_toMarker);
                            }
                            if ((_fromMarker != null &&
                                    BusStops.busStopMap[result] !=
                                        _fromMarker.position) ||
                                _fromMarker == null) {
                              Marker newMarker = Marker(
                                  // This marker id can be anything that uniquely identifies each marker.
                                  markerId: MarkerId(
                                    ('$result'),
                                  ),
                                  //make position respond to user selection
                                  position: BusStops.busStopMap[result],
                                  infoWindow: InfoWindow(
                                    title: ('$result'),
                                  ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueBlue));
                              _toMarker = newMarker;
                              _markers.add(newMarker);

                              _getPolyline();

                              calculateDistanceKM();
                              calculateDistance();
                              noOfStops();
                              // _onCameraMove(CameraPosition(target: _fromMarker.position,  );

                              setState(() {
                                _cardStates = CardStates.halfVisible;
                              });
                            } else {
                              print("Snack Bar Displayed");
                              _showSnackBar();
                              //Add toast to show user you can't do this.

                              polylineCoordinates.clear();
                            }
                          });
                        }

                        whereToSelected();

                        polylineCoordinates.clear();
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
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
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
    }
    _addPolyLine();
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
    // kmString = km.toString();
    print('$km kilometers');
    // });
  }

  String _setImage() {
    var a = BusStops.busStopIndex.values.first;

    var b = BusStops.busStopIndex.values.last;

    if (BusStops.busStopIndex.values != a || b) {
      return 'images/2nd_node.png';
    } else {
      return 'images/1st_node.png';
    }
  }

  void noOfStops() {
    // setState(() {
    var x = BusStops.busStopIndex[_fromMarker.markerId.value];
    var y = BusStops.busStopIndex[_toMarker.markerId.value];

    print('$x' '-' '$y');
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

    // });
  }

  Widget buildListView() {
    Map stopListMap = stopLists.asMap();
    print(stopListMap);
    var i = 0;

    for (i = 0; i < stopLists.length; i++) {
      print(stopListMap[i]);
    }

    // final indiStopListMap = stopListMap[0];
    // print(indiStopListMap);
    print('::::::');

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: stopListMap.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  width: 70,
                  height: 70,
                  // color: Colors.white,
                  // child: Text(
                  //   'Icon',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(_setImage()),
                    ),
                  ),
                  // borderRadius: BorderRadius.circular(10),
                  // color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(color: Colors.grey, spreadRadius: 1)
                  // ]),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '${stopListMap[index]}',
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  width: 50,
                  height: 75,
                  // color: Colors.white,
                  child: Text(
                    '15:00',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
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
      },
    );
  }

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

enum CardStates { hidden, halfVisible, fullVisible }
