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
}
