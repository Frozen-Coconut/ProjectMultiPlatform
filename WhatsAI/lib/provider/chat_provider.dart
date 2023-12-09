import 'package:flutter/foundation.dart';
import 'package:whats_ai/chat.dart';

class ChatProvider extends ChangeNotifier {
  final List<Chat> _chats = [
    Chat(
      owner: 'Papan',
      text: 'Halo...',
      createdAt: DateTime.now(),
    ),
    Chat(
      owner: 'Lele',
      text: 'Halo juga',
      createdAt: DateTime.now().add(const Duration(minutes: 3)),
    ),
    Chat(
      owner: 'Har',
      text: 'Hmmm',
      createdAt: DateTime.now().add(const Duration(minutes: 5)),
    ),
  ];

  List<Chat> get chats => _chats;
}
