import 'package:flutter/foundation.dart';
import 'package:whats_ai/chat.dart';

class ChatProvider extends ChangeNotifier {
  final List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  void add(Chat chat) {
    _chats.add(chat);
    notifyListeners();
  }
}
