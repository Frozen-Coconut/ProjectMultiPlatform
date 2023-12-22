class ChatRoom {
  final String owner;
  final String name;
  final DateTime updatedAt;

  ChatRoom({required this.owner, required this.name, required this.updatedAt});

  ChatRoom.fromSnapshot(Map<String, dynamic> snapshot)
      : owner = snapshot['owner'],
        name = snapshot['name'],
        updatedAt = snapshot['updated_at'].toDate();
}
