import 'package:brtbus/Components/brttap.dart';
import 'package:brtbus/Components/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackAppBar extends StatelessWidget {
  final String title;

  const BackAppBar({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        height: 100,
        padding: EdgeInsets.only(top: 25),
        // alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            // color: Colors.blue,
            ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
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
            ],
          ),
        ),
      ),
    );
  }
}
