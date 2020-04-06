import 'package:flutter/material.dart';
import 'package:brtbus/Components/themes.dart';
import 'menu_item.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  AnimationController _animationController;
  // final bool isSliderOpen = false;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void _onIconTapped() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenwidth,
          right: isSideBarOpenedAsync.data ? 0 : screenwidth - 45,
          child: Row(children: <Widget>[
            Expanded(
              child: Container(
                color: primaryBlue,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100),
                    MenuItem(
                      icon: Icons.home,
                      title: "Map",
                      onTap: () {
                        _onIconTapped();
                        // BlocProvider.of<NavigationBloc>(context)
                        //     .add(NavigationEvents.HomePageClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.person,
                      title: "Route",
                      onTap: () {
                        _onIconTapped();

                        // BlocProvider.of<NavigationBloc>(context)
                        //     .add(NavigationEvents.MyAccountClickedEvent);
                      },
                    ),
                    MenuItem(
                      icon: Icons.add_alert,
                      title: "News",
                      onTap: () {
                        _onIconTapped();
                        // BlocProvider.of<NavigationBloc>(context)
                        //     .add(NavigationEvents.MyOrdersClickedEvent);
                      },
                    ),
                    // MenuItem(
                    //   icon: Icons.card_giftcard,
                    //   title: "Wishlist",
                    // ),
                    Divider(
                      height: 64,
                      thickness: 0.5,
                      color: Colors.white,
                      indent: 32,
                      endIndent: 32,
                    ),
                    MenuItem(
                      icon: Icons.settings,
                      title: "Settings",
                    ),
                    MenuItem(
                      icon: Icons.info,
                      title: "About",
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.9),
              child: GestureDetector(
                onTap: () {
                  _onIconTapped();
                },
                child: ClipPath(
                  clipper: CustomMenuClipper(),
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 100,
                    color: primaryBlue,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: secondaryBlue,
                      size: 35,
                    ),
                  ),
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
