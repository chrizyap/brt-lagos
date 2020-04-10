import 'package:brtbus/Components/Search/searchWidget.dart';
import 'package:brtbus/Components/busStops.dart';
import 'package:brtbus/Components/polylines.dart';
import 'package:brtbus/Components/themes.dart';
import 'package:brtbus/Components/Sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as A;
import 'package:intl/intl.dart';
import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:brtbus/Components/googleMaps.dart';
import 'package:brtbus/Components/tripDetails.dart';

class MyHomePage extends StatefulWidget with NavigationStates {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final A.Distance distance = new A.Distance();

  Duration _duration = Duration(milliseconds: 500);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String kmString;

  var going = TextEditingController();
  var coming = TextEditingController();

  GoogleMapController mapController;

  String googleAPiKey = "AIzaSyAVTGrgDL3-VpSWaEjdvgHDJxc_ffzWGmE";

  //static LatLng _tbsTerminal = LatLng(6.445721, 3.401200);
  //static LatLng _cmsTerminal = LatLng(6.451145, 3.389201);

  // Map timeTo = {'hours': 5, 'minutes': 30};

  static const LatLng _center = const LatLng(6.5244, 3.3792);

  @override
  void initState() {
    super.initState();
    SearchWidget.controller =
        AnimationController(vsync: this, duration: _duration);
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMaps(),
          SearchWidget(),
          SideBar(),
          TripDetails(),
        ],
      ),
    );
  }

  ///Belongs with the Slide Trabsition Widget
  ///

}
