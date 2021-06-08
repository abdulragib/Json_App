import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; //convert jason object in to string
import 'package:http/http.dart'
    as http; // to add this package go to https://pub.dev/packages/http/install

void main() async {
  List _data = await getJson();

  // String _body = "";
  // for (int i = 0; i < _data.length; i++) {
  //   print("Title: ${_data[i]['title']}");
  //   print("Body: ${_data[i]['body']}");
  // }
  // _body = _data[0]['body'];

  runApp(
    new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("JSON Parse"),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: new Center(
          child: new ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int position) {
                if (position.isOdd)
                  return new Divider(); // due to this divider position 1,2,3,4,5 convert in to 1,3,5. so we have to make index.
                final index = position ~/ 2; // we dividing position by 2
                // and returning an integer result
                return new ListTile(
                  title: new Text(
                    "${_data[index]['title']}",
                    style: TextStyle(fontSize: 13.9),
                  ),
                  subtitle: new Text(
                    "${_data[index]['body']}",
                    style: new TextStyle(
                        fontSize: 13.4,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.green,
                    child: new Text(
                      '${_data[index]['body'][0].toString().toUpperCase()}',
                      style: new TextStyle(
                          fontSize: 19.4, color: Colors.orangeAccent),
                    ),
                  ),
                  onTap: () {
                    _showOnTapMessage(context, "${_data[index]['title']}");
                  },
                );
              }),
        ),
      ),
    ),
  );
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text('App'),
    content: new Text(message),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: new Text("Ok"),
      ),
    ],
  );
  showDialog(builder: (context) => alert, context: context);
}

Future<List> getJson() async {
  String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  http.Response response = await http.get(Uri.parse(apiUrl));

  return json.decode(response.body); // return a list type
}

//The http.get() method returns a Future that contains a Response.
// Future is a core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.
// The http.Response class contains the data received from a successful http call.

//Async means that this function is asynchronous and you might need to wait a bit to get its result.
// Await literally means - wait here until this function is finished and you will get its return value.
// Future is a type that ‘comes from the future’ and returns value from your asynchronous function. It can complete with success(.then) or with
// an error(.catchError).

//http.get(uri.parse()) is used to get data from url.
//uri.parse used to covert string into url.

//ListTile widget is used to populate a ListView in Flutter. It contains title as well as leading or trailing icons.
//A list tile contains one to three lines of text optionally flanked by icons or other widgets, such as check boxes.
//The itemCount parameter decides how many times the callback function in itemBuilder will be called.

//ListView.builder is a way of constructing the list where children’s (Widgets) are built on demand.
// However, instead of returning a static widget, it calls a function which can be called multiple times (based on itemCount )
// and it’s possible to return different widget at each call.
//https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb for item count,item builder and listview

//circleavatar used to create a circular logo where we can pass logo or color.
//${_data[position]['body'][0]} by using this we are printing first letter of body in circle avatar.

//https://stackoverflow.com/questions/49100196/what-does-buildcontext-do-in-flutter to get deep knowledge about buildcontext.

//In its on the pressed property, we have to use the showDialog widget of flutter. It takes context and a builder.
// In builder, we provide the AlertDialog widget with title, content(Description of a title), and actions (Yes or no buttons), and our alert dialog box is ready to use.

//buildcontext is used to handle location of widget in a widget tree.
//Navigator.pop(context) used to switch the screen


