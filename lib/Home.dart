import 'package:flutter/material.dart';
import 'package:flutter_app/Grid/TestFile.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Grid/Category_List.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Test'),
      ),
      body: new ListView(
        children: <Widget>[
          //Grid Button
          new Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RaisedButton(
                  child: Text('Start'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  onPressed: () {
                    //Intent Next Activity
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          Grid()), // Passing Intent With InputString
                    );

                    Fluttertoast.showToast(
                        msg: "Grid Activity",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM_LEFT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
              )
          ),
          //Example!
          new Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: RaisedButton(
                  child: Text('Test File'),
                  textColor: Colors.white,
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  onPressed: () {
                    //Intent Next Activity
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          TestFile()), // Passing Intent With InputString
                    );
                  }
              )
          ),


        ],
      ),
    );
  }
}
