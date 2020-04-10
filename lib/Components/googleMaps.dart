import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:brtbus/Components/polylines.dart';
import 'package:latlong/latlong.dart' as A;

class GoogleMaps extends StatelessWidget {
  // GoogleMaps({Key key, this.mapController, this.currentMapType})
  //     : super(key: key);

  static GoogleMapController mapController;
  static const LatLng _center = const LatLng(6.5244, 3.3792);
  MapType currentMapType = MapType.normal;
  // static Set<Marker> markers = {};

  static void _onCameraMove(CameraPosition position) {
    //_lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        // compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        mapType: currentMapType,
        markers: Polylines.markers,
        polylines: Set<Polyline>.of(Polylines.polylines.values),
        onCameraMove: _onCameraMove,
      ),
    );
  }
}
