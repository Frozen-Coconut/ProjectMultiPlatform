import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:whats_ai/chat.dart';

class ChatProvider extends ChangeNotifier {
  static final CollectionReference _chats =
      FirebaseFirestore.instance.collection('chats');

  Future<List<Chat>> getChats(
      {required String chatRoomName, required String chatRoomOwner}) async {
    QuerySnapshot querySnapshot = await _chats
        .where('chat_room_name', isEqualTo: chatRoomName)
        .where('chat_room_owner', isEqualTo: chatRoomOwner)
        .get();
    final allData = querySnapshot.docs
        .map((doc) => Chat.fromSnapshot(doc.data() as Map<String, dynamic>))
        .toList();
    return allData;
  }

  void add(Chat chat) {
    _chats.add({
      'owner': chat.owner,
      'text': chat.text,
      'created_at': chat.createdAt,
      'chat_room_name': chat.chatRoomName,
      'chat_room_owner': chat.chatRoomOwner
    });
    notifyListeners();
  }
}
