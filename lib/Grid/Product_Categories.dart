import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/Grid/TestFile.dart';
import 'package:flutter_app/dataclass/Heros.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



class ProductCategories extends StatefulWidget {
  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {


  //Its A faction type
  // User to retrieve
  // data from server
  // OR
  // Api
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Products Categories'),
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
            return GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 3,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(snapshot.data.length, (index) {
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: _CategoryList(snapshot.data[index].imageurl,snapshot.data[index].name),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            TestFile()), // Passing Intent With InputString
                      );
                    },
                  );
                }),
              );
            }
        },
      )
    );
  }

  //
  // ignore: non_constant_identifier_names
  Widget _CategoryList(String imageUrl, String name)
  {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black, width: 0.5),
        image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter
        ),
      ),
      child: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 20,
              color: Colors.black,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,2,0,0),
                child: Text(name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 13.0,),
                ),
              ),
            ),
          )
      ),
    );
  }

}
