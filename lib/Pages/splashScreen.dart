import 'package:brtbus/Components/Sidebar/sidebar_layout.dart';
import 'package:brtbus/Components/showRoute.dart';
import 'package:brtbus/Components/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../../config/bento_colors.dart';
// import '../../routes/route_names.dart';

class BentoSplashScreen extends StatefulWidget {
  @override
  _BentoSplashScreenState createState() => _BentoSplashScreenState();
}

class _BentoSplashScreenState extends State<BentoSplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SideBarLayout()));
    });

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => ShowRoute()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topLeft,
              colors: [
                primaryBlue,
                secondaryBlue,
              ]),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'images/png/app-icon.png',
                scale: 7,
              )),
        ),
      ),
    );
  }
}
