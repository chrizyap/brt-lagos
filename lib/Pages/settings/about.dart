import 'package:brtbus/Components/brttap.dart';
import 'package:flutter/material.dart';

import 'package:brtbus/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          // color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.10,
                child: Center(
                    child: Text(
                  'Navigation with Ease',
                  style: TextStyle(fontSize: 20),
                )),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'We are a team of passionate designers and developers invested in building applications for the benefit of humanity. Our goal with BRT Lagos is to make travelling in the most populous city in Africa effective and affortable for all.',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'You can support our mission by leaving a nice review and sharing it with friends and family',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            'Thank you.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    )),
              ),
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.10,
                child: BrtTap(
                  onTap: () => launch('https://thedigiscript.com'),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Image.asset('images/digiscript-logo-small.png',
                          scale: 1.5),
                      Text('Digiscript Technologies')
                    ],
                  )),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
