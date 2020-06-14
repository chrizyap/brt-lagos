import 'package:brtbus/Components/brttap.dart';
import 'package:brtbus/Components/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarYes extends StatelessWidget {
  final String title;

  const AppBarYes({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        height: 50,
        // alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            // color: Colors.blue,
            ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BrtTap(
                child: SvgPicture.asset(
                  'images/svg/back.svg',
                  width: 50,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      // height: 4,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
