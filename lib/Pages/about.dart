import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget with NavigationStates {
  // final String pageText;
  // AboutPage(this.pageText);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('About'),
        backgroundColor: Colors.blue[900],
      ),
      body: new Center(
        child: new Text('About'),
      ),
    );
  }
}
