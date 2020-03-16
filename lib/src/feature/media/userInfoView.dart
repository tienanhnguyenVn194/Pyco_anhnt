import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/data/model/user_info.dart';
import 'package:flutter_app/src/feature/media/mediaPresenter.dart';
import 'package:swipedetector/swipedetector.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> implements Controls {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  BuildContext _context;
  MediaPresenter _presenter;
  User people;
  bool _isViewDetails = false;
  int _selectedIndex = 0;
  bool _isNetworkConnected = true;

  _Profile() {
    _presenter = new MediaPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isNetworkConnected = true;
    _isViewDetails = false;
    int _selectedIndex = 0;
    _presenter.nextPeople();
  }

  Widget NoNetworkConnected = Center(
    child: Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Center(
        child: Text(
          "Lỗi kết nối mạng",
          textScaleFactor: 2.0,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double widthScreen = MediaQuery.of(context).size.width;

    final loadImage = people != null
        ? new CachedNetworkImage(
            imageUrl: people.picture,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : NoNetworkConnected;

    Widget MainCard() {
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
                      child: Container(
                        child: DefaultTabController(
                          length: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                constraints: BoxConstraints.expand(height: 100),
                                child: TabBarView(
                                  children: <Widget>[
                                    TabInfo(
                                        "My name is",
                                        people != null
                                            ? "${people.name.title} ${people.name.first} ${people.name.last}"
                                            : ""),
                                    TabInfo("My SSN is",
                                        people != null ? people.SSN : ""),
                                    TabInfo(
                                        "My address is",
                                        people != null
                                            ? "${people.location.street} - ${people.location.city} - ${people.location.state}"
                                            : ""),
                                    TabInfo(
                                        "My phone is",
                                        people != null
                                            ? "${people.phone}  ${people.cell}"
                                            : ""),
                                    TabInfo("My password is",
                                        people != null ? people.password : ""),
                                  ],
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints.expand(height: 100),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      constraints:
                                          BoxConstraints.expand(height: 50),
                                      padding:
                                          EdgeInsets.only(left: 60, right: 60),
                                      child: TabBar(
                                          indicator: UnderlineTabIndicator(
                                            borderSide: BorderSide(
                                                color: Colors.green,
                                                width: 3.0),
                                            insets: EdgeInsets.fromLTRB(
                                                40.0, 0.0, 40.0, 40.0),
                                          ),
                                          onTap: (index) {
                                            setState(() {
                                              _selectedIndex = index;
                                            });
                                          },
                                          tabs: [
                                            Tab(
                                              icon: Icon(
                                                Icons.person_pin,
                                                color: _selectedIndex == 0
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: _selectedIndex == 1
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                Icons.map,
                                                color: _selectedIndex == 2
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                Icons.phone,
                                                color: _selectedIndex == 3
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                            Tab(
                                              icon: Icon(
                                                Icons.lock,
                                                color: _selectedIndex == 4
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          color: Colors
                              .black12, //                   <--- border color
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
          ));
    }

    Widget backgroundView() {
      double widthScreen = MediaQuery.of(context).size.width;
      double heightScreen = MediaQuery.of(context).size.height;
      return Container(
          child: Column(
            children: <Widget>[
              Container(
                width: widthScreen,
                height: heightScreen / 3,
                child: loadImage,
              ),
            ],
          ),
          color: Color.fromRGBO(249, 249, 249, 1),
          width: widthScreen,
          height: heightScreen);
    }

    Widget sizeBoxControl = Stack(
      children: <Widget>[
        backgroundView(),
        Container(
          padding: EdgeInsets.only(left: 15, right: 10, top: 20),
          child: MainCard(),
        )
      ],
    );

    Widget resultView;
    if (!_isNetworkConnected) {
      resultView = Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text("Tinder"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.pushNamed(context, '/favorited');
                }),
          ],
        ),
        body: NoNetworkConnected,
      );
    } else {
      resultView = Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text("Tinder"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.pushNamed(context, '/favorited');
                }),
          ],
        ),
        body: Center(
          child: Container(
            child: SwipeDetector(
                child: sizeBoxControl,
                onSwipeUp: () {
                  viewDetails();
                },
                onSwipeDown: () {
                  setState(() {
                    _isViewDetails = false;
                  });
                },
                onSwipeLeft: () {
                  setState(() {
                    _isNetworkConnected = true;
                  });
                  _presenter.nextPeople();
                },
                onSwipeRight: () {
                  setState(() {
                    _isNetworkConnected = true;
                  });
                  _presenter.addFavorite(people);
                }),
          ),
        ),
      );
    }
    return resultView;
  }

  void getPeople() {}

  void viewDetails() {
    setState(() {
      _isViewDetails = true;
    });
  }

  @override
  void showError(String message) {
    // TODO: implement showError
    setState(() {
      _isNetworkConnected = false;
    });
  }

  @override
  void showPeople(User user) {
    // TODO: implement showPeople
    setState(() {
      _isNetworkConnected = true;
      people = user;
    });
  }
}

class TabInfo extends StatelessWidget {
  String title;
  String content;

  TabInfo(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
    );
  }
}
