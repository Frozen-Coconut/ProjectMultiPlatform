import 'dart:convert';

import 'package:crypto/crypto.dart';

class User {
  final String username;
  final String _password;

  User({required this.username, required String password})
      : _password = sha1.convert(utf8.encode(password)).toString();

  bool checkPassword(String password) {
    return sha1.convert(utf8.encode(password)).toString() == _password;
  }
}
