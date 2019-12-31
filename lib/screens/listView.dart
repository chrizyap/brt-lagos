import 'package:flutter/material.dart';

//DataSearch is an extension of search
class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);

    final suggestionList = query.isEmpty
        ? recentBusStops
        : busstops.where((p) => p.toLowerCase().startsWith(query)).toList();

    //Navigator.pop(context);
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // showResults(context);
          close(context, suggestionList[index]);
        },
        leading: Icon(Icons.directions_bus),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //return Container();

    final suggestionList = query.isEmpty
        ? recentBusStops
        : busstops.where((p) => p.toLowerCase().startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          showResults(context);
          close(context, suggestionList[index]);
        },
        leading: Icon(Icons.directions_bus),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

final busstops = [
  "TBS Terminal",
  "CMS Terminal",
  "Leventis",
  "Costain",
  "Iponri",
  "Stadium",
  "Barracks",
  "Moshalashi Terminal",
  "Fadeyi",
  "Onipanu",
  "Palmgrove",
  "Obanikoro",
  "Anthony",
  "Idiroko",
  "Maryland",
  "New Garage",
  "Ojota",
  "Ketu",
  "Mile 12 Terminal",
  "Owode Onirun",
  "Idera",
  "Irawo",
  "MajidunAwori",
  "MajidunOgolunto",
  "Argic Terminal",
  "Ikorodu Terminal",
//Agic  Basically the same as Agric Terminal
//Abuna Can't find it on Gmaps
];
final recentBusStops = [
  "Fadeyi",
  "Onipanu",
  "Palmgrove",
  "Obanikoro",
];
