import 'package:brtbus/Components/brttap.dart';
import 'package:flutter/material.dart';

class NewsListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BrtTap(
        child: Container(
            height: 79,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(children: <Widget>[
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFF1C1AFF),
                ),
                // child: Image.asset(widget.imgSrc, scale: widget.imgSize),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Traffic Report',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              'Traffic on the Lekki Epe expressway backed up to the first intersection.',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('15:00',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins')),
                ],
              )
            ])),
      ),
    );
  }
}
