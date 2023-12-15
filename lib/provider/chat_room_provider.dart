import 'package:flutter/foundation.dart';
import 'package:whats_ai/chat_room.dart';

class ChatRoomProvider extends ChangeNotifier {
  final List<ChatRoom> _chatRooms = [
    ChatRoom(owner: 'user1@example.com', name: 'character1'),
    ChatRoom(owner: 'user2@example.com', name: 'character1'),
    ChatRoom(owner: 'user3@example.com', name: 'character1'),
    ChatRoom(owner: 'user1@example.com', name: 'character2'),
    ChatRoom(owner: 'user1@example.com', name: 'character3'),
  ];

  List<ChatRoom> get chats => _chatRooms;

  bool add(ChatRoom chatRoom) {
    try {
      _chatRooms.firstWhere((element) =>
          element.owner == chatRoom.owner && element.name == chatRoom.name);
      return false;
    } catch (exception) {
      _chatRooms.add(chatRoom);
      notifyListeners();
      return true;
    }
  }
}
