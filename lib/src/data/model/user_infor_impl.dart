import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_app/src/data/helper/database.dart';
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