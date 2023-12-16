class Chat {
  final String owner;
  final String text;
  final DateTime createdAt;
  final String chatRoomName;
  final String chatRoomOwner;

  Chat(
      {required this.owner,
      required this.text,
      required this.createdAt,
      required this.chatRoomName,
      required this.chatRoomOwner});

  Chat.fromSnapshot(Map<String, dynamic> snapshot)
      : owner = snapshot['owner'],
        text = snapshot['text'],
        createdAt = snapshot['created_at'].toDate(),
        chatRoomName = snapshot['chat_room_name'],
        chatRoomOwner = snapshot['chat_room_owner'];
}
