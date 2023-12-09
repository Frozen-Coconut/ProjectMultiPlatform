import 'package:flutter/foundation.dart';
import 'package:whats_ai/chat.dart';

class ChatProvider extends ChangeNotifier {
  final List<Chat> _chats = [
    Chat(
      owner: 'Papan',
      text: 'Halo...',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Chat(
      owner: 'Lele',
      text: 'Halo juga',
      createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    Chat(
      owner: 'Har',
      text: 'Hmmm',
      createdAt: DateTime.now(),
    ),
  ];

  List<Chat> get chats => _chats;

  void add(Chat chat) {
    _chats.add(chat);
    notifyListeners();
  }
}
