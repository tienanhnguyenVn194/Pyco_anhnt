import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/data/model/user_info.dart';
import 'package:flutter_app/src/feature/media/mediaPresenter.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> implements Controls {

  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  BuildContext _context;
  MediaPresenter _presenter;
  User people;
  bool _isViewDetails = false;
  bool _isNetworkConnected = true;
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    _isNetworkConnected = true;
    _isViewDetails = false;
    _selectedIndex = 0;
    _presenter.nextPeople();
  }

  Widget NoNetworkConnected = Center(
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Center(
        child: Text(
          "Lỗi kết nối mạng, vui lòng mở kết nối mạng hoặc thử mở lại trang",
          textScaleFactor: 2.0,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        backgroundView(),
        MainCard(),
      ],
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
                      color: Colors.black12, //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: widthScreen / 5,
                      backgroundImage: NetworkImage(people.picture),
                    ),
                  )
              )
          ),
        ],
      ),
    );
  }

  void getPeople() {}

  void viewDetails() {
    setState(() {
      _isViewDetails = true;
    });
  }

  @override
  void showFavoritePeople() {
    Navigator.of(_context).pushNamed("/favorite");
  }

  @override
  void showPeople(User user) {
    setState(() {
      _isNetworkConnected = true;
      people = user;
    });
  }

  @override
  void showError(String error) {
    setState(() {
      _isNetworkConnected = false;
    });
  }
}