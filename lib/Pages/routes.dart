import 'package:flutter/material.dart';

import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';

class RoutesPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Routes",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
