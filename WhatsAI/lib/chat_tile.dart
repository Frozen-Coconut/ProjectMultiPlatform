import 'package:flutter/material.dart';
import 'package:whats_ai/chat.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;
  final String owner;

  const ChatTile({super.key, required this.chat, required this.owner});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(chat.owner == owner ? 'Me' : chat.owner),
      subtitle: Text(chat.text),
      trailing: Text(chat.createdAt.toIso8601String()),
      onTap: () {},
    );
  }
}
