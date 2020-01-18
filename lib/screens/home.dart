import 'dart:ffi';

import 'package:brtbus/core/busStops.dart';
import 'package:brtbus/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'info.dart';
import 'about.dart';
import 'settings.dart';
import 'listView.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MyHomePage extends StatefulWidget {
  final String value;
  MyHomePage({this.value = ""});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showSnackBar() {
    final snackBar = new SnackBar(
      content: new Text("Sorry, you can't choose the same bus stop!"),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    //How to display snackbar.
    _scaffoldKey.currentState.showSnackBar(snackBar);
    if (isShowingCard == true) {
      setState(() {
        isShowingCard = false;
      });
    }
  }

  bool isShowingCard = false;

  var going = TextEditingController();
  var coming = TextEditingController();

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

  void _onCameraMove(CameraPosition position) {
    //_lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    // var _blankFocusNode = new FocusNode();
    //SystemChannels.textInput.invokeMethod('TextInput.hide');
    //FocusScope.of(context).unfocus();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('BRT Lagos'),
          backgroundColor: Colors.blue[900],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                  title: new Text("Map"),
                  leading: Icon(Icons.map),
                  trailing: Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  }),
              new ListTile(
                  title: new Text("Info"),
                  leading: Icon(Icons.contacts),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new InfoPage("Info")));
                  }),
              Divider(
                color: Colors.black,
              ),
              new ListTile(
                  title: new Text("Settings"),
                  leading: Icon(Icons.settings),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new SettingsPage("Settings")));
                  }),
              new ListTile(
                  title: new Text("About"),
                  leading: Icon(Icons.help),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new InfoPage("About")));
                  }),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              //compassEnabled: true,
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
              duration: Duration(milliseconds: 700),
              //Deatails Card
              //bottom: isShowingCard?75.0:
              top: isShowingCard
                  ? MediaQuery.of(context).size.height - 300
                  : MediaQuery.of(context).size.height,

              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // SizedBox(
                        //   width: 10.0,
                        // ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.timer,
                            color: Colors.blue[900],
                          ),
                        ),
                        // SizedBox(
                        //   width: 10.0,
                        // ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '1hr 20m (10km)',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 25.0,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 80.0,
                        //   height: 75.0,
                        // ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              iconSize: 30,
                              onPressed: () {
                                print('close button pressed');
                                setState(() {
                                  isShowingCard = false;
                                });
                              },
                              icon: Icon(
                                Icons.close,
                              ),
                              color: Colors.red),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.attach_money,
                            color: Colors.blue[900],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '500',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 25.0,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.directions_bus,
                            color: Colors.blue[900],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontFamily: '',
                              fontSize: 25.0,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          iconSize: 30.0,
                          onPressed: () {
                            print('go button pressed');
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                      ],
                    ),
                  ],
                ),

                // child: Text("Details go here"),
                width: MediaQuery.of(context).size.width,
                height: 200,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                ),
              ),
            ),
            Positioned(
              top: 50.0,
              right: 20.0,
              left: 20.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ],
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
                              infoWindow: InfoWindow(
                                title: ('$result'),
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
                        }
                      });
                    }

                    whereFromSelected();
                    polylineCoordinates.clear();
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
                    hintText: "Where from?",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 104.0,
              right: 20.0,
              left: 20.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 5.0),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ],
                ),
                child: TextField(
                  controller: coming,
                  //Pushing the second screen and wait for the result
                  cursorColor: Colors.black,
                  //controller: appState.destinationController,
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
                                //snippet: '5 Star Rating',
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue));
                          _toMarker = newMarker;
                          _markers.add(newMarker);
                          setState(() {
                            isShowingCard = true;
                          });
                        } else {
                          print("Snack Bar Displayed");
                          _showSnackBar();
                          //Add toast to show user you can't do this.

                          polylineCoordinates.clear();
                        }

                        _getPolyline();
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
                        Icons.directions_bus,
                        color: Colors.blue[900],
                      ),
                    ),
                    hintText: "Where to?",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 10.0),
                  ),
                ),
              ),
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
    setState(() {});
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
}
