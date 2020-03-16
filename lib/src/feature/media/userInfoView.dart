import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/data/model/user_info.dart';
import 'package:flutter_app/src/feature/media/mediaPresenter.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  BuildContext _context;
  MediaPresenter _presenter;
  User people;

  Future<http.Response> fetchAlbum() {
    return http.get('https://randomuser.me/api/0.4/?randomapi');
  }

  Future<User> getUser() async {
    String url = 'https://quotes.rest/qod.json';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Tinder',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tinder'),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    backgroundView(),
                    MainCard(),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('errors');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget backgroundView() {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
        child: Column(
          children: <Widget>[
            Container(
                color: Color.fromRGBO(44, 45, 50, 1),
                width: widthScreen,
                height: heightScreen / 3),
          ],
        ),
        color: Color.fromRGBO(249, 249, 249, 1),
        width: widthScreen,
        height: heightScreen);
  }

  Widget MainCard() {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double iconSize = 40.0;
    return Container(
      width: widthScreen - 16 * 2,
      height: widthScreen,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(248, 248, 248, 1),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: widthScreen - 16 * 2,
                height: widthScreen * 2 / 3,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "My address is",
                            style: TextStyle(
                                color: Color.fromRGBO(174, 174, 174, 1),
                                fontSize: 15),
                          ),
                          Text(
                            "4661 Auburn Ave",
                            style: TextStyle(
                                color: Color.fromRGBO(44, 45, 45, 1),
                                fontSize: 23),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () => {},
                                child: Container(
                                    width: iconSize,
                                    height: iconSize,
                                    child: Icon(
                                      Icons.access_alarm,
                                      size: 30,
                                      color: Colors.black12,
                                    )),
                              ),
                              InkWell(
                                  onTap: () => {},
                                  child: Container(
                                      width: iconSize,
                                      height: iconSize,
                                      child: Icon(
                                        Icons.today,
                                        size: 30,
                                        color: Colors.black12,
                                      ))),
                              InkWell(
                                  onTap: () => {},
                                  child: Container(
                                      width: iconSize,
                                      height: iconSize,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 30,
                                            height: 2,
                                            color: Colors.green,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Icon(
                                            Icons.map,
                                            size: 30,
                                            color: Colors.green,
                                          )
                                        ],
                                      ))),
                              InkWell(
                                  onTap: () => {},
                                  child: Container(
                                      width: iconSize,
                                      height: iconSize,
                                      child: Icon(
                                        Icons.phone,
                                        size: 30,
                                        color: Colors.black12,
                                      ))),
                              InkWell(
                                  onTap: () => {},
                                  child: Container(
                                      width: iconSize,
                                      height: iconSize,
                                      child: Icon(
                                        Icons.lock,
                                        size: 30,
                                        color: Colors.black12,
                                      ))),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          new Align(
              alignment: new Alignment(0.0, -0.7),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color:
                          Colors.black12, //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: widthScreen / 5,
                      backgroundImage: NetworkImage(people.picture),
                    ),
                  ))),
        ],
      ),
    );
  }
}
