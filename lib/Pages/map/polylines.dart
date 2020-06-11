import 'dart:async';

import 'package:brtbus/Pages/map/searchWidget.dart';
import 'package:brtbus/Components/busStops.dart';
import 'package:brtbus/Pages/map/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as A;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:brtbus/Components/tripDetails.dart';

List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints = PolylinePoints();

final Map<PolylineId, Polyline> polylines = {};

final A.Distance distance = new A.Distance();

Map timeTo = {'hours': 5, 'minutes': 30};

class Polylines {
  static StreamController<bool> createRouteStreamController =
      StreamController<bool>.broadcast();

  static StreamController<bool> addFromMarkerStreamController =
      StreamController<bool>.broadcast();

  static StreamController<bool> addToMarkerStreamController =
      StreamController<bool>.broadcast();

  static Set<Marker> markers = {};
  static Marker toMarker;
  static Marker fromMarker;
  static final Map<PolylineId, Polyline> polylines = {};
  static String googleAPiKey = "AIzaSyAVTGrgDL3-VpSWaEjdvgHDJxc_ffzWGmE";

  static void whereFromSelected() {
    markers.remove(Polylines.fromMarker);
    polylines.clear();
    Marker newMarker = Marker(
        markerId: MarkerId(
          ('${Texts.going.text}'),
        ),
        position: BusStops.busStopMap[Texts.going.text],
        infoWindow: InfoWindow(title: ('${Texts.going.text}')),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
    Polylines.fromMarker = newMarker;
    markers.add(Polylines.fromMarker);
  }

  static void whereToSelected() {
    markers.remove(Polylines.toMarker);
    Marker newMarker = Marker(
        markerId: MarkerId(
          ('${Texts.coming.text}'),
        ),
        position: BusStops.busStopMap[Texts.coming.text],
        infoWindow: InfoWindow(
          title: ('${Texts.coming.text}'),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
    Polylines.toMarker = newMarker;
    markers.add(newMarker);
  }

  static void createRoute() {
    polylineCoordinates.clear();
    getPolyline();
    addPolyLine();
    calculateDistanceKM();
    calculateDistance();
    Details.noOfStops();

    if (SearchWidget.controller.isDismissed) {
      SearchWidget.controller.forward();
      print(SearchWidget.controller.status);
    } else if (SearchWidget.controller.isCompleted &&
        fromMarker != null &&
        toMarker != null) {
      SearchWidget.controller.forward();
      print(SearchWidget.controller.status);
    } else {
      SearchWidget.controller.reverse();
    }
  }

  static addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue[600],
      width: 4,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    polylines.addAll(polylines);
    print('Polyline Added');
  }

  static getPolyline() async {
    List<PointLatLng> result1 = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        fromMarker.position.latitude,
        fromMarker.position.longitude,
        toMarker.position.latitude,
        toMarker.position.longitude);
    if (result1.isNotEmpty) {
      result1.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
  }

  static void calculateDistance() {
    final double meter = distance(
      new A.LatLng(toMarker.position.latitude, toMarker.position.longitude),
      new A.LatLng(fromMarker.position.latitude, fromMarker.position.longitude),
    );
    print('$meter meters');
  }

  static void calculateDistanceKM() {
    //setState(() {
    final double km = distance.as(
      A.LengthUnit.Kilometer,
      new A.LatLng(toMarker.position.latitude, toMarker.position.longitude),
      new A.LatLng(fromMarker.position.latitude, fromMarker.position.longitude),
    );
    double timeTaken = km / 35;
    timeTo = {
      'hours': timeTaken.floor(),
      'minutes': ((timeTaken % 1) * 60).ceil()
    };

    print('$km kilometers');
  }
}
