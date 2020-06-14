import 'package:brtbus/Components/brtButtonWidget.dart';
import 'package:brtbus/Components/busStops.dart';
import 'package:brtbus/Pages/map/polylines.dart';
import 'package:flutter/material.dart';
import 'package:brtbus/Animation/FadeAnimation.dart';
import 'package:brtbus/Pages/map/searchListView.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:brtbus/Pages/map/googleMaps.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'search.dart';
import 'package:brtbus/Pages/map/map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Texts {
  static var going = TextEditingController();
  static var coming = TextEditingController();
}

class SearchWidget extends StatelessWidget {
  static AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          padding: EdgeInsets.only(top: 120),
          child: Column(
            children: <Widget>[
              FadeAnimation(
                  1.35,
                  Container(
                    height: 50.0,
                    width: 397.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          topLeft: Radius.circular(4)),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: Texts.going,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        dynamic result = await showSearch(
                            context: context, delegate: DataSearch());
                        Texts.going.text = result;
                        print('Where from: ${Texts.going.text}');
                        if (Polylines.fromMarker == null) {
                          Polylines.whereFromSelected();
                        } else if (Polylines.fromMarker != null &&
                            Polylines.toMarker != null &&
                            BusStops.busStopMap[result] != Texts.coming.text) {
                          Polylines.whereFromSelected();
                          Polylines.createRoute();
                        } else if (Polylines.fromMarker == Polylines.toMarker) {
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
              FadeAnimation(
                  1.35,
                  Container(
                    height: 50.0,
                    width: 397.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4)),
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
                      enabled: Polylines.fromMarker != null,
                      controller: Texts.coming,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (query) {},
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        dynamic result = await showSearch(
                            context: context, delegate: DataSearch());
                        Texts.coming.text =
                            Texts.going.text != result ? result : '';
                        print('Where to: ${Texts.coming.text}');

                        if (Polylines.fromMarker != null &&
                            BusStops.busStopMap[result] !=
                                Polylines.fromMarker.position) {
                          Polylines.whereToSelected();
                          Polylines.createRoute();
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
            ],
          ),
        ),
      ),
    );
  }
}

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
  return snackBar;
}
