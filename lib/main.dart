import 'dart:convert';

import 'package:excel/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchText = TextEditingController();

  var change = ValueNotifier<String>("");
  Widget futureList() {
    return FutureBuilder(
      future: hitApi(),
      builder: (context, data) {
        if (data.hasData && searchText.text.isEmpty) {
          return ValueListenableBuilder(
            valueListenable: change,
            builder: (BuildContext context, String value, c) {
              if (value.isEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _list.length,
                  itemBuilder: (builder, index) {
                    print(_list.elementAt(index).city);
                    return ListTile(
                      title: Text(
                        _list[index].city,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    );
                  },
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: searchList.length,
                itemBuilder: (builder, index) {
                  print(searchList.elementAt(index).city);
                  return ListTile(
                    title: Text(
                      searchList[index].city,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: searchList.length,
          itemBuilder: (builder, index) {
            print(searchList.elementAt(index).city);
            return ListTile(
              title: Text(
                searchList[index].city,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Text(
              "Select City",
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            height: 100.0,
            width: 500.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: TextField(
                controller: searchText,
                onChanged: (value) {
                  filterSearchResults(value);
                  change.value = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          futureList(),
        ],
      ),
    );
  }

  List<Welcome> _list = [];
  Future<List<Welcome>> hitApi() async {
    final response = await http.get(
        "https://raw.githubusercontent.com/tailoristic/jsonT/main/db.json");
    var decodeData = json.decode(response.body);
    for (var i in decodeData) {
      final data = Welcome(city: i['city'], id: i['id']);
      _list.add(data);
    }
    //welcomeFromJson(decodeData);
    return _list;
  }

  List<Welcome> searchList = [];
  Future<List<Welcome>> filterSearchResults(String query) async {
    var data = _list;
    searchList.clear();
    data.map((e) {
      if (e.city.toUpperCase().contains(query.toUpperCase())) {
        searchList.add(e);
      }
    }).toList();

    setState(() {
      if (query.isEmpty) {
        _list.clear();
        searchList.clear();
      }
    });
    return searchList;
  }
}
