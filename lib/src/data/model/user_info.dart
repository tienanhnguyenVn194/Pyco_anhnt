import 'dart:convert';

import 'package:flutter_app/src/data/model/Name.dart';
import 'package:flutter_app/src/data/model/location.dart';

class User {
  int id;
  String gender;
  Name name;
  Location location;
  String email;
  String username;
  String password;
  String phone;
  String cell;
  String SSN;
  String picture;

  User(
      {this.gender,
      this.name,
      this.location,
      this.email,
      this.username,
      this.password,
      this.phone,
      this.cell,
      this.SSN,
      this.picture});

  User.fromMap(Map<String, dynamic> map)
      : this.gender = map["gender"],
        this.name = Name.fromMap(map["name"]),
        this.location = Location.fromMap(map["location"]),
        this.email = map["email"],
        this.username = map["username"],
        this.password = map["password"],
        this.phone = map["phone"],
        this.cell = map["cell"],
        this.SSN = map["SSN"],
        this.picture = map["picture"];

  User.fromMapDb(Map<String, dynamic> map)
      : this.gender = map["gender"],
        this.name = Name.fromMap(json.decode(map["name"].toString())),
        this.location =
            Location.fromMap(json.decode(map["location"].toString())),
        this.email = map["email"],
        this.username = map["username"],
        this.password = map["password"],
        this.phone = map["phone"],
        this.cell = map["cell"],
        this.SSN = map["SSN"],
        this.picture = map["picture"];

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["gender"] = gender;
    map["name"] = name.toJsonString();
    map["location"] = location.toJsonString();
    map["email"] = email;
    map["username"] = username;
    map["password"] = password;
    map["phone"] = phone;
    map["cell"] = cell;
    map["SSN"] = SSN;
    map["picture"] = picture;
    return map;
  }

  toJson() {
    return {
      "gender": gender,
      "name": name.toJson(),
      "location": location.toJson(),
      "email": email,
      "username": username,
      "password": password,
      "phone": phone,
      "cell": cell,
      "SSN": SSN,
      "picture": picture
    };
  }
}

abstract class UserRepository {
  Future<User> fetchUser();
  Future<User> createUser(User user);
  Future<List<User>> getAllUser();
  Future<int> deleteUser(User user);
}
