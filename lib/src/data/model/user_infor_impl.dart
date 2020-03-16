import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/src/data/helper/database.dart';
import 'package:http/http.dart' as http;

import 'user_info.dart';

class RandomUserRepository implements UserRepository {
  static const _kRandomUserUrl = 'https://randomuser.me/api/0.4/?randomapi';
  final JsonDecoder _decoder = new JsonDecoder();
  DatabaseHelper dbHelper;

  RandomUserRepository() {
    dbHelper = DatabaseHelper();
  }

  @override
  Future<User> fetchUser() async {
    final response = await http.get(_kRandomUserUrl);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error load user [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }

    final userContainer = _decoder.convert(jsonBody)['results'][0]['user'];
    return User.fromMap(userContainer);
  }

  @override
  Future<User> createUser(User people) async {
    return await dbHelper.addUser(people);
  }

  @override
  Future<int> deleteUser(User user) async {
    return await dbHelper.deleteByEmail(user.email);
  }

  @override
  Future<List<User>> getAllUser() async {
    return await dbHelper.getAllUser();
  }
}

class FetchDataException implements Exception {
  String _messages;

  FetchDataException(this._messages);

  String toString() {
    return "Exception : $_messages";
  }
}
