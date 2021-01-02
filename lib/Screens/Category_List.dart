import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/List_Of_Shops.dart';
import 'package:flutter_app/dataclass/Heros.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  // Webservice Get data From
  // Given Url
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
    }

    return listof;
  }




  String name, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text('Categories'),
        ),
        body:FutureBuilder(
          future: getAllData(),
          builder: (BuildContext c, AsyncSnapshot snapshot){
            if(snapshot.data == null)
            {
            return Center(
              child: new Text('Loading Data...'),
              );
            }else
              {
                return StaggeredGridView.countBuilder(
                  crossAxisCount:4,
                  itemCount: 19,
                  // itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) => new GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ShopList()), // Passing Intent With InputString
                      );
                    },
                    child: new Card(
                      //Shape Fro Card View
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data[index].imageurl),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            child: Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white
                                            .withOpacity(1.0)),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 3 : 1 ),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                );
              }
          },
        )
    );
  }
}
