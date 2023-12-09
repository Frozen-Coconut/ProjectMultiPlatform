import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/chat.dart';
import 'package:whats_ai/chat_tile.dart';
import 'package:whats_ai/provider/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  final String owner;

  const ChatScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    final List<Chat> chats =
        Provider.of<ChatProvider>(context, listen: false).chats;
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
