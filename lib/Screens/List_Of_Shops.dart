import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Product_Categories.dart';
import 'package:flutter_app/dataclass/Heros.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
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
        title: Text('List Of Shops'),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container(
                margin: EdgeInsets.all(10.0),
                height: 50.0,
                child: new FutureBuilder(
                    future: getAllData(),
                    builder: (BuildContext c, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: new Text("Loading Data..."),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext c, int index) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 0.0, 0.0, 0.0),
                                    child: new Row(
                                      children: <Widget>[
                                        new ClipOval(
                                          child: Image.network(
                                            snapshot.data[index].imageurl,
                                            height: 20.0,
                                            width: 20.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        new Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: new Text(
                                              snapshot.data[index].name),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Fluttertoast.showToast(
                                        msg: snapshot.data[index].name,
                                        //Message For toast
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM_LEFT,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                ));
                          });
                    } //Else
                  } //builder
                ),
              ),
            ),
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
            height: 560,
            child: new FutureBuilder(
                future: getAllData(),
                builder: (BuildContext c, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: new Text("Loading Data..."),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext c, int index) {
                          return Container(
                            height: 150,
                            child: Card(
                              //Shape For Card View
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 5.0,
                              child: InkWell(
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
                                    //Button Top Left
                                    child: new Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      //textDirection: TextDirection.rtl,
                                      children:[
                                        Expanded(
                                          //Column For Left Widget
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Box At Top Right
                                                Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Opacity(
                                                      opacity: 0.5,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          Fluttertoast.showToast(
                                                              msg: 'B',
                                                              //Message For toast
                                                              toastLength:
                                                              Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .BOTTOM_LEFT,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0);
                                                        },
                                                        child: Text(
                                                            snapshot.data[index].name),
                                                        color: Colors.black,
                                                        textColor: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors.white,
                                                                width: 2),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                7.0)),
                                                        padding: EdgeInsets.fromLTRB(
                                                            10, 10, 10, 10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //Fro Space Between Button
                                                //And Payment Methods
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                // Payment Methods
                                                new Row(
                                                  children: [
                                                    new SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    //For COD
                                                    InkWell(
                                                      onTap: (){
                                                        Fluttertoast.showToast(
                                                            msg: 'COD',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM_LEFT,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.payments_rounded,
                                                        color: Colors.white,
                                                        size: 20.0,
                                                        semanticLabel:
                                                        'COD',
                                                      ),
                                                    ),
                                                    //Space
                                                    new SizedBox(
                                                      width: 6.0,
                                                    ),
                                                    // For Card
                                                    InkWell(
                                                      onTap: (){
                                                        Fluttertoast.showToast(
                                                            msg: 'Pay By Card',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM_LEFT,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.credit_card,
                                                        color: Colors.white,
                                                        size: 20.0,
                                                        semanticLabel:
                                                        'Card',
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                new SizedBox(
                                                  height: 5.0,
                                                ),
                                                //For Speed And Accuracy
                                                new Row(
                                                  children: [
                                                    //Space From Left

                                                    new SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    //For COD
                                                    Text('Speed:'+snapshot.data[index].team,
                                                      style: TextStyle(color: Colors.white,fontSize: 13.0,),),
                                                    //Space
                                                    new SizedBox(
                                                      width: 6.0,
                                                    ),
                                                    // For Card
                                                    Text('Accuracy:'+snapshot.data[index].team,
                                                        style: TextStyle(color: Colors.white,fontSize: 13.0,)),
                                                  ],
                                                ),

                                              ],
                                            ),
                                        ),
                                        //For Write Widget
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            //For Heading Text
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(0.0,8.0,8.0,0.0),
                                                child: Text(snapshot.data[index].name, style: TextStyle(fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.bold),),
                                              ),
                                            ),

                                            //For Flag
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0.0, 0.0, 15.0, 0.0),
                                                child: Image.network(
                                                  'https://ak.picdn.net/shutterstock/videos/5372003/thumb/1.jpg',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                              ),


                                            //For Calender
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 30, 8.0, 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    print('Calendar');
                                                  },
                                                  child: Icon(
                                                    Icons
                                                        .perm_contact_calendar_rounded,
                                                    color: Colors.white,
                                                    size: 45.0,
                                                    semanticLabel:
                                                        'Text to announce in accessibility modes',
                                                  ),
                                                ),
                                              )


                                            ],
                                          ),
                                      ],
                                    )
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        ProductCategories()), // Passing Intent With InputString
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    );
                  } //Else
                } //builder

                ),
          ),
        ],
      ),
    );
  }
}
