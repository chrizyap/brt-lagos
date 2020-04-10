import 'package:brtbus/Components/themes.dart';
import 'package:flutter/material.dart';

class AppBar extends StatelessWidget {
  final String title;

  const AppBar({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: primaryBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  height: 4,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
