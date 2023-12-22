import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:whats_ai/chat_room.dart';

class ChatRoomProvider extends ChangeNotifier {
  static final CollectionReference _chatRooms =
      FirebaseFirestore.instance.collection('chat_rooms');

  Future<List<ChatRoom>> getChatRooms({required String owner}) async {
    QuerySnapshot querySnapshot =
        await _chatRooms.where('owner', isEqualTo: owner).get();
    final allData = querySnapshot.docs
        .map((doc) => ChatRoom.fromSnapshot(doc.data() as Map<String, dynamic>))
        .toList();
    return allData;
  }

  Future<bool> add(ChatRoom chatRoom) async {
    QuerySnapshot querySnapshot = await _chatRooms
        .where('owner', isEqualTo: chatRoom.owner)
        .where('name', isEqualTo: chatRoom.name)
        .get();
    final allData = querySnapshot.docs
        .map((doc) => ChatRoom.fromSnapshot(doc.data() as Map<String, dynamic>))
        .toList();
    if (allData.isNotEmpty) {
      return false;
    } else {
      _chatRooms.add({
        'owner': chatRoom.owner,
        'name': chatRoom.name,
        'updated_at': chatRoom.updatedAt
      });
      notifyListeners();
      return true;
    }
  }
}
