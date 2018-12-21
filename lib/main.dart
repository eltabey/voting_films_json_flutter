import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  print(_data[1]['title']); //just a string
  String _body = "";

  for (int i = 0; i < _data.length; i++) {
    print("Title ${_data[i]['title']}");
    print("Body: ${_data[i]['description']}");
  }

  _body = _data[0]['description'];

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('JSON Parse'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new Center(
          child: new ListView.builder(
              itemCount: _data.length,
              padding: const EdgeInsets.all(14.5),
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  children: <Widget>[
                    new Divider(height: 5.5),
                    ListTile(
                      title: Text(
                        "${_data[position]['title']}",
                        style: new TextStyle(fontSize: 17.9),
                      ),
                      subtitle: (Image(
                        image: NetworkImage("${_data[position]['cover_url']}"),
                        height: 200.0,
                        width: 200.0,
                      )),
                      onTap: () => _showonTapMessage(
                          context, _data[position]['description']),

                      /*Card(
                          child: Image(image: AssetImage("${_data[position]['cover_url']}")),
                        ),*/

                      /*subtitle: Text("${_data[position]['description']}",//description
                          style: new TextStyle(
                              fontSize: 13.9,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic)
                      ),*/
                      /*leading: new CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Text(
                          "${_data[position]['body']}",
                          style: new TextStyle(
                              fontSize: 16.4, color: Colors.orangeAccent),
                        ),
                      ),*/
                    )
                  ],
                );
              })),
    ),
  ));
}

void _showonTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: Text("My App"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
  // showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiUrl =
      'https://gist.githubusercontent.com/yannski/3019778/raw/dfb34d018165f47b61b3bf089358a3d5ca199d96/movies.json';
  //https://jsonplaceholder.typicode.com/posts
//https://gist.githubusercontent.com/yannski/3019778/raw/dfb34d018165f47b61b3bf089358a3d5ca199d96/movies.json
  http.Response response = await http.get(apiUrl);

  return json.decode(response.body); // returns a List type
}

//showDialog(context: context, builder: (context) {
//return alert;
////     return new AlertDialog(
////      title: new Text('App'),
////      content: new Text(message),
////      actions: <Widget>[
////        new FlatButton(
////            onPressed: () {
////              Navigator.pop(context);
////            },
////            child: new Text('OK'))
////      ],
////    );
//});

/*
   void _showOnTapMessage(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text('App'),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('OK'))
    ],
  );
  //showDialog(context: context, child: alert);
  showDialog(context: context, builder: (context) => alert);



}
 */

/*
  var format = new DateFormat("yMd");

                var date = format.format(new DateTime.fromMicrosecondsSinceEpoch(_features[index]['properties']['updated']*1000, isUtc: false));
 */
