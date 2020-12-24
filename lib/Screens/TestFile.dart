

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dataclass/Heros.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:hexcolor/hexcolor.dart';

import '../AppTheme.dart';
import 'Product_Categories.dart';
// TestFile



class TestFile extends StatefulWidget {
  @override
  _TabsDemoState createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TestFile> {

  bool multiple = true;
  int count = 0;
  int a ;

  bool addedToCart = false;

  List<String> categories = ["0","1","2"];
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

      //categories.add(i["name"]);
    }

    return listof;
  }

  changeText(int index) {
    setState(() {
      count++;
      addedToCart = true;
    });
  }

  remove(int index) {
    setState(() {
      count = 0;
      addedToCart = false;
    });
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
        home: DefaultTabController(
            length: categories.length,
            child: new Scaffold(
                appBar: new AppBar(
                  title: new Text("Sub Categories"),
                  leading: GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,  // add custom icons also
                    ),
                    onTap: (){
                        Navigator.pop(context);
                    },
                  ),
                  bottom: new TabBar(
                    isScrollable: true,
                    tabs: List<Widget>.generate(categories.length, (int index) {
                      return new Tab(//icon: Icon(Icons.directions_car),
                          text: 'Tab '+categories[index]);
                    }),

                  ),
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
                      return new TabBarView(
                        children: List<Widget>.generate(categories.length, (int index){

                          return GridView.count(
                              crossAxisCount: 2,
                              children: List.generate(snapshot.data.length, (index) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: _subCategory(snapshot.data[index].name, snapshot.data[index].imageurl, index ),
                                ),
                                //Single Tap
                                onTap: (){
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        TestFile()), // Passing Intent With InputString
                                  );*/
                                  Fluttertoast.showToast(
                                  msg: snapshot.data[index].name,
                                  //Message For toast
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM_LEFT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: HexColor('#D91400'),
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                                },
                                //Double Tap
                                onDoubleTap: ()
                                {
                                  print(index);
                                  changeText(index);
                                  //changeText(index);
                                },
                              );
                            }),
                          );
                        })
                      );
                    }
                  }
                ),
            )
        )
    );
  }
  
  // Creating Separate
  // Widget Layout
  // For Every Tab
  Widget _subCategory(String name, String imageUrl, int index)
  {

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black, width: 0.5),
          image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter
          ),
        ),
        child: Column(
          children:<Widget>[

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Visibility
                (
                    //Now addedToCart = Fale
                    // that's why _removeToCart row
                    // Will no show
                    visible: addedToCart == true,
                    child: _removeToCart(index),
                ),
            ),

            //For Bottom Banner
            Expanded(child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.white.withOpacity(0.5),
                  margin: const EdgeInsets.fromLTRB(0,0,0,0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,2,0,0),
                        child: Text(name, style: TextStyle(fontSize: 15)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,0,0,0),
                        child: Text("Quantity", style: TextStyle(fontSize: 13)),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,5,5),
                          child: Text("AED:25.00", style: TextStyle(fontSize: 15)),
                        ),
                      )

                    ],
                  ),
                )
            ),)
          ],
        ),
      ),

    );
  }


  Widget _removeToCart(int index){

    return Row(
      children:<Widget>[
        Expanded(
          flex: 0,
          child: InkWell(
            child: Icon(Icons.remove_circle_outline),
            onTap:(){
              remove(index);
              Fluttertoast.showToast(
                  msg: "Remove",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM_LEFT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
          ),
        ),

        Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  Fluttertoast.showToast(
                      msg: "Add"+count.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM_LEFT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
                child:new CircleAvatar(
                  backgroundColor: Colors.green,
                  child: new Text('x'+count.toString()),
                  foregroundColor: Colors.white,
                ),

              ),
            )
        )
      ],
    );
  }


}
