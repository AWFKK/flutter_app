import 'package:flutter/material.dart';
import 'package:flutter_app/dataclass/Heros.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:hexcolor/hexcolor.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selectable GridView',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Get Data From Web Service
  Future<List<Heros>> getAllData() async {
    //BaseUrl Or Api Url
    var api = "https://simplifiedcoding.net/demos/marvel";
    //Getting Response
    var data = await http.get(api);

    //Converting
    //Response Data Into Json Format
    var JsonData = json.decode(data.body);

    List<Heros> listof = [];
    for (var i in JsonData) {
      Heros data = new Heros(
          i["name"],
          i["realname"],
          i["team"],
          i["firstappearance"],
          i["createdby"],
          i["publisher"],
          i["imageurl"],
          i["bio"]);
      listof.add(data);
      debugPrint(data.toString());
      print(i["name"]);

      //categories.add(i["name"]);
    }

    return listof;
  }


 final List<IconData> _icons = [
    Icons.offline_bolt,
    Icons.ac_unit,
    Icons.dashboard,
    Icons.backspace,
    Icons.cached,
    Icons.edit,
    Icons.face,
  ];

  List<IconData> _selectedIcons = [] ;

  @override
  Widget build(BuildContext context) {

    Widget gridViewSelection = GridView.count(
      childAspectRatio: 2.0,
      crossAxisCount: 3,
      mainAxisSpacing: 20.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      children: _icons.map((iconData) {
        return GestureDetector(
          onTap: () {
            //_selectedIcons.clear();

            setState(() {
              _selectedIcons.add(iconData);
            });
          },
          onDoubleTap: (){
            for(int i =0; i<_selectedIcons.length; i++)
            {
              print(_selectedIcons.indexOf(_icons[i]).toString());
            }

          },
          child: GridViewItem(iconData, _selectedIcons.contains(iconData)),
        );
      }).toList(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Selectable GridView'),
      ),
      body: FutureBuilder(
        future: getAllData(),
        builder: (BuildContext c, AsyncSnapshot snapshot){
          if(snapshot.data == null)
          {
            return Center(
              child: new Text('Loading Data...'),
            );
          }else{
            return gridViewSelection;
          }
        }
      ),
    );
  }
}

class GridViewItem extends StatelessWidget {
  final IconData _iconData;
  final bool _isSelected;

  GridViewItem(this._iconData, this._isSelected);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        _iconData,
        color: Colors.white,
      ),
      shape: CircleBorder(),
      fillColor: _isSelected ? Colors.blue : Colors.black,
      onPressed: null,
    );
  }
}