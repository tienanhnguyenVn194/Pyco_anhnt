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
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String phone;
  String cell;
  String SSN;
  String picture;

  User(this.gender, this.name, this.location, this.email, this.username,
      this.password, this.phone, this.cell, this.SSN, this.picture);

  User.fromMap(Map<String, dynamic> map)
      : this.gender = map["gender"],
        this.name = Name.fromMap(map["name"]),
        this.location = Location.fromMap(map["location"]),
        this.email = map["email"],
        this.username = map["username"],
        this.password = map["password"],
        this.salt = map["salt"],
        this.md5 = map["md5"],
        this.sha1 = map["sha1"],
        this.sha256 = map["sha256"],
        this.registered = map["registered"],
        this.dob = map["dob"],
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
        this.salt = map["salt"],
        this.md5 = map["md5"],
        this.sha1 = map["sha1"],
        this.sha256 = map["sha256"],
        this.registered = map["registered"],
        this.dob = map["dob"],
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
    map["salt"] = salt;
    map["sha1"] = sha1;
    map["sha256"] = sha256;
    map["registered"] = registered;
    map["dob"] = dob;
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
      "salt": salt,
      "sha1": sha1,
      "sha256": sha256,
      "registered": registered,
      "dob": dob,
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