import 'package:flutter/foundation.dart';
import 'package:whats_ai/user.dart';

class UserProvider extends ChangeNotifier {
  final List<User> _users = [
    User(username: 'Papan', password: 'Papan'),
    User(username: 'Lele', password: 'Lele'),
    User(username: 'Har', password: 'Har'),
  ];

  List<User> get users => _users;

  void add(User user) {
    _users.add(user);
    notifyListeners();
  }
}
