import 'dart:async';
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
  void initState() {
    super.initState();
    value.text = "";
  }

  Completer<GoogleMapController> _controller = Completer();
  static TextEditingController value = TextEditingController();

  static const LatLng _center = const LatLng(6.5244, 3.3792);

  final Set<Marker> _markers = {};
  LatLng _tbsTerminal = LatLng(6.445721, 3.401200);
  LatLng _cmsTerminal = LatLng(6.451145, 3.389201);
  LatLng _leventis = LatLng(6.455254, 3.380983);
  LatLng _costain = LatLng(6.480660, 3.367996);
  LatLng _iponri = LatLng(6.487398, 3.364117);
  LatLng _stadium = LatLng(6.501144, 3.362595);
  LatLng _barracks = LatLng(6.506293, 3.363750);
  LatLng _moshalashiTerminal = LatLng(6.519948, 3.364994);
  LatLng _fadeyi = LatLng(6.528089, 3.367087);
  LatLng _onipanu = LatLng(6.534815, 3.366926);
  LatLng _palmgrove = LatLng(6.541314, 3.367351);
  LatLng _obanikoro = LatLng(6.547142, 3.366773);
  LatLng _anthony = LatLng(6.558832, 3.367001);
  LatLng _idiroko = LatLng(6.565531, 3.366500);
  LatLng _maryland = LatLng(6.571467, 3.367076);
  LatLng _newGarage = LatLng(6.584761, 3.376472);
  LatLng _ojota = LatLng(6.587780, 3.378858);
  LatLng _ketu = LatLng(6.597003, 3.385641);
  LatLng _mile12Terminal = LatLng(6.606810, 3.399453);
  LatLng _owodeOnirun = LatLng(6.611326, 3.411039);
  LatLng _idera = LatLng(6.610537, 3.420705);
  LatLng _irawo = LatLng(6.609840, 3.422123);
  LatLng _majidunAwori = LatLng(6.619691, 3.462980);
  LatLng _majidunOgolunto = LatLng(6.619959, 3.473586);
  LatLng _argicTerminal = LatLng(6.625813, 3.483925);
  //LatLng _agic = LatLng(6.445721,3.401200); Basically the same as Agric Terminal
  //LatLng _abuna = LatLng(6.445721,3.401200); Can't find it on Gmaps
  LatLng _ikoroduTerminal = LatLng(6.621859, 3.502544);

  MapType _currentMapType = MapType.normal;
/*
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
*/

//GET THE USERS LOCATION
  void getCurrentLocation() async {
    print("GET USER METHOD RUNNING =========");

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    //LatLng _userLocation = LatLng(position.longitude, position.latitude);
    print(
        "the longitude is: ${position.longitude} and the latitude is: ${position.latitude} ");
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _tbsTerminal.toString(),
          ),
          position: _tbsTerminal,
          infoWindow: InfoWindow(
            title: 'TBS Terminal',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _cmsTerminal.toString(),
          ),
          position: _cmsTerminal,
          infoWindow: InfoWindow(
            title: 'CMS Terminal',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _leventis.toString(),
          ),
          position: _leventis,
          infoWindow: InfoWindow(
            title: 'Leventis',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _costain.toString(),
          ),
          position: _costain,
          infoWindow: InfoWindow(
            title: 'Costain',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _iponri.toString(),
          ),
          position: _iponri,
          infoWindow: InfoWindow(
            title: 'Iponri',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _stadium.toString(),
          ),
          position: _stadium,
          infoWindow: InfoWindow(
            title: 'Stadium',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _barracks.toString(),
          ),
          position: _barracks,
          infoWindow: InfoWindow(
            title: 'Barracks',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _moshalashiTerminal.toString(),
          ),
          position: _moshalashiTerminal,
          infoWindow: InfoWindow(
            title: 'Moshalashi Terminal',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _fadeyi.toString(),
          ),
          position: _fadeyi,
          infoWindow: InfoWindow(
            title: 'Fadeyi',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _onipanu.toString(),
          ),
          position: _onipanu,
          infoWindow: InfoWindow(
            title: 'Onipanu',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _palmgrove.toString(),
          ),
          position: _palmgrove,
          infoWindow: InfoWindow(
            title: 'Palmgrove',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _obanikoro.toString(),
          ),
          position: _obanikoro,
          infoWindow: InfoWindow(
            title: 'Obanikoro',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _anthony.toString(),
          ),
          position: _anthony,
          infoWindow: InfoWindow(
            title: 'Anthony',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _idiroko.toString(),
          ),
          position: _idiroko,
          infoWindow: InfoWindow(
            title: 'Idikoro',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _maryland.toString(),
          ),
          position: _maryland,
          infoWindow: InfoWindow(
            title: 'Maryland',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _newGarage.toString(),
          ),
          position: _newGarage,
          infoWindow: InfoWindow(
            title: 'New Garage',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _ojota.toString(),
          ),
          position: _ojota,
          infoWindow: InfoWindow(
            title: 'Ojota',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _ketu.toString(),
          ),
          position: _ketu,
          infoWindow: InfoWindow(
            title: 'Ojota',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _mile12Terminal.toString(),
          ),
          position: _mile12Terminal,
          infoWindow: InfoWindow(
            title: 'Mile 12 Terminal',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _owodeOnirun.toString(),
          ),
          position: _owodeOnirun,
          infoWindow: InfoWindow(
            title: 'Owode Onirun',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _idera.toString(),
          ),
          position: _idera,
          infoWindow: InfoWindow(
            title: 'Idera',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _irawo.toString(),
          ),
          position: _irawo,
          infoWindow: InfoWindow(
            title: 'Irawo',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _majidunAwori.toString(),
          ),
          position: _majidunAwori,
          infoWindow: InfoWindow(
            title: 'Majidun Awori',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _majidunOgolunto.toString(),
          ),
          position: _majidunOgolunto,
          infoWindow: InfoWindow(
            title: 'Majidun Ogolunto',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _argicTerminal.toString(),
          ),
          position: _argicTerminal,
          infoWindow: InfoWindow(
            title: 'Argic Terminal',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
      _markers.add(Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(
            _ikoroduTerminal.toString(),
          ),
          position: _ikoroduTerminal,
          infoWindow: InfoWindow(
            title: 'Ikorodu Terminal',
            //snippet: '5 Star Rating',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
    });
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
              // decoration: new Decoration(Colors.red),
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
              bottom: 120.0,
              right: 10.0,
              //left: ,

              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      // materialTapTargetSize: MaterialTapTargetSize.padded,
                      foregroundColor: Colors.blue[900],
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
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
                  onTap: () {
                    showSearch(context: context, delegate: DataSearch());
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
                  //Pushing the second screen and wait for the result
                  cursorColor: Colors.black,
                  //controller: appState.destinationController,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (query) {},

                  onTap: () {
                    showSearch(context: context, delegate: DataSearch());
                  },

/*
                  onChanged: (text) {
                    value = text;
                  },
                  */
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
