import 'package:flutter/material.dart';



class InfoPage extends StatelessWidget {

  final String pageText;
  InfoPage(this.pageText);
@override
Widget build(BuildContext context){
  return new Scaffold(
    appBar: new AppBar(title: new Text(pageText),
      backgroundColor: Colors.blue[900],
    ),
    body:  new Center(
      child: new Text(pageText),
    ),
  );
}

}