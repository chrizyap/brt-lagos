import 'package:flutter/material.dart';

import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:brtbus/Pages/newsListTile.dart';

class NewsPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,

              end: Alignment(0.8, 0.0),
              colors: [
                const Color(0xFF0096E1),
                const Color(0xFFF1C1AFF),
              ], // whitish to gray
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 75),
                Container(
                  child: Text(
                    'News',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                ),
                SizedBox(height: 50),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile(),
                NewsListTile()
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
