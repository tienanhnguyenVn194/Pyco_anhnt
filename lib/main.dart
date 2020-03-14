import 'package:flutter/material.dart';
import 'package:flutter_app/src/feature/media/userInfoView.dart';

void main() => runApp(MyApp());

final routes = {
  '/': (BuildContext context) => new Profile(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder',
      routes: routes,
      initialRoute: '/',
    );
  }
}