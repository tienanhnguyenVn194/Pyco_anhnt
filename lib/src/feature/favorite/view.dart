import 'package:flutter/material.dart';
import 'package:flutter_app/src/data/model/user_info.dart';
import 'package:flutter_app/src/feature/favorite/presenter.dart';

class DataSave extends StatefulWidget {
  @override
  _DataSave createState() => _DataSave();
}

class _DataSave extends State<DataSave> implements DataContract {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  FavoritePagePresenter _presenter;
  List<User> peoples;
  bool _isLoading;

  _DataSave() {
    _presenter = new FavoritePagePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadFavoritePeople();
  }

  void _showSnackBar(String text) {
    _globalKey.currentState.showSnackBar(new SnackBar(
        content: Text(text),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.grey));
  }

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (_isLoading) {
      result = Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (peoples.length <= 0) {
        result = MaterialApp(
          title: 'Tinder',
          home: Scaffold(
            key: _globalKey,
            appBar: AppBar(
              title: Text("Favorite People"),
              centerTitle: true,
            ),
            body: Center(
              child: Text("Không có danh sách yêu thích"),
            ),
          ),
        );
      } else {
        result = MaterialApp(
          title: 'Tinder',
          home: Scaffold(
            key: _globalKey,
            appBar: AppBar(
              title: Text("Favorite People"),
              centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: peoples.length - 1,
                itemBuilder: (context, index) {
                  final widgetItem = Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: ListTile(
                            title: Text(
                                "${peoples[index].name.title} ${peoples[index].name.first} ${peoples[index].name.last}"),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            leading: new CircleAvatar(
                              backgroundImage:
                                  NetworkImage(peoples[index].picture),
                            )),
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                  return widgetItem;
                }),
          ),
        );
      }
    }
    return result;
  }

  @override
  void unFavorite(User user) {}

  @override
  void showError(String error) {
    _showSnackBar(error);
  }

  @override
  void showFavorires(List<User> users) {
    setState(() {
      _isLoading = false;
      peoples = users;
    });
  }
}
