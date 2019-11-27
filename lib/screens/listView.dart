import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home.dart';

class DataListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Where to?"),
          backgroundColor: Colors.blue[900],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                }),

            //Use navigator.pop to return to home after search value is added
            //or you could use the close method
          ],
        ),
        // body: TextField(),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class DataSearch extends SearchDelegate<String> {
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
    //return value back to text field

    //close(context, this.query)

    Navigator.pop(context, query);
    //and then display build result in text field.
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
          showResults(context);
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
  "moshalashiTerminal",
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

//noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
