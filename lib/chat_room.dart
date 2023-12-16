class ChatRoom {
  final String owner;
  final String name;

  ChatRoom({required this.owner, required this.name});

  ChatRoom.fromSnapshot(Map<String, dynamic> snapshot)
      : owner = snapshot['owner'],
        name = snapshot['name'];
}
