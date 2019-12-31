import 'dart:async';
import 'package:brtbus/core/busStops.dart';
import 'package:brtbus/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:brtbus/themes.dart';
import 'info.dart';
import 'about.dart';
import 'settings.dart';
import 'listView.dart';

class MyHomePage extends StatefulWidget {
  final String value;
  MyHomePage({this.value = ""});
  @override
  _MyAppState createState() => _MyAppState();

  // String value;
}

class _MyAppState extends State<MyHomePage> {
  var going = TextEditingController();
  var coming = TextEditingController();
  void initState() {
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(6.5244, 3.3792);

  final Set<Marker> _markers = {};
  Marker _toMarker;
  Marker _fromMarker;

  MapType _currentMapType = MapType.normal;

//GET THE USERS LOCATION
  void getCurrentLocation() async {
    print("GET USER METHOD RUNNING =========");

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    //LatLng _userLocation = LatLng(position.longitude, position.latitude);
    print(
        "the longitude is: ${position.longitude} and the latitude is: ${position.latitude} ");
  }

  void _onCameraMove(CameraPosition position) {
    //_lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // var _blankFocusNode = new FocusNode();
    //SystemChannels.textInput.invokeMethod('TextInput.hide');
    //FocusScope.of(context).unfocus();
    return MaterialApp(
      home: Scaffold(
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
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
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

                    print(result);
                    void whereFromSelected() {
                      setState(() {
                        if (_fromMarker != null) {
                          _markers.remove(_fromMarker);
                        }
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
                      });
                    }

                    whereFromSelected();
                  },

                  cursorColor: Colors.black,
                  //controller: appState.locationController,
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.blue[900],
                      ),
                    ),
                    hintText: "Where from?",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 105.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
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
                    print(result);
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
                        } else {
                          print("You can't choose the same bus stop!");
                        }
                      });
                    }

                    whereToSelected();
                  },

                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.directions_bus,
                        color: Colors.blue[900],
                      ),
                    ),
                    hintText: "Where to?",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
