import 'package:flutter_role_demo/Model/login/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('user');
  }

  Box get userBox => Hive.box('user'); 


  void saveToken(String token) {
    userBox.put('token', token);
  }

  String? getToken() {
    return userBox.get('token');
  }

  void removeToken() {
    userBox.delete('token');
  }

  bool hasToken() {
    final token = userBox.get('token');
    return token != null && token.isNotEmpty;
  }

  Future<void> saveUser(User user) async {
    userBox.put('user', user.toJson());
  }

  User? getUser() {
    final data = userBox.get('user');
    if (data != null) {
      return User.fromJson(data);
    }
    return null;
  }

  void removeUser() {
    userBox.delete('user');
  }
}

