import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'dataclass/Categories.dart';
import 'dataclass/shopcategories.dart';


class Shopss extends StatefulWidget {
  @override
  _ShopssState createState() => _ShopssState();
}

class _ShopssState extends State<Shopss> {

  //Its A faction type
  // User to retrieve
  // data from server
  // OR
  // Api
  Future<List<shopcategories>> getAllData() async {
    //BaseUrl Or Api Url
    var api = "https://grocery.redlinesol.com/webservices/shopcategories";
    //Getting Response
    var data = await http.get(api);

    //Converting
    //Response Data Into Json Format
    var JsonData = json.decode(data.body);


    //Parsing JSON
    var rest = JsonData["result"] as List;


    print(rest);
    List<shopcategories> listof = [];
    for (var i in rest) {
      shopcategories data = new shopcategories(
          i["category_name"],
          i["image"],
          i["category_id"]);
      listof.add(data);
      debugPrint(data.toString());

      print(i["category_name"]);

    }

    return listof;

  }


  Future<List<Categories>> getCategories() async {
    //BaseUrl Or Api Url
    var api = "https://grocery.redlinesol.com/webservices/categories";
    //Getting Response
    var data = await http.get(api);

    //Converting
    //Response Data Into Json Format
    var JsonData = json.decode(data.body);

    print(JsonData);
    //Parsing JSON
    var rest = JsonData["result"] as List;


    print(rest);
    List<Categories> listof = [];
    for (var i in rest) {
      Categories data = new Categories(
          i["category_name"],
          i["image"],
          i["category_id"],
          i["total_count"],
      );
      listof.add(data);
      debugPrint(data.toString());

      print(i["category_name"]);

    }

    return listof;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('List Of Shops'),
      ),
      body: FutureBuilder(
        future: getCategories(),
          builder: (BuildContext c, AsyncSnapshot snapshot){
            if(snapshot.data == null)
            {
              return Center(
                child: new Text('Loading Data...'),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(snapshot.data[index].category_name));

                },
              );
            }
          }
      ),
    );
  }
}
