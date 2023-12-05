import 'package:flutter/material.dart';
import 'package:whats_ai/chat.dart';
import 'package:whats_ai/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  final List<Chat> chats = [
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
  final String owner;

  ChatScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return ChatTile(
              chat: chats[index],
              owner: owner,
            );
          },
        ),
      ),
    );
  }
}
