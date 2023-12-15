import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/chat.dart';
import 'package:whats_ai/chat_tile.dart';
import 'package:whats_ai/provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomName;

  const ChatScreen({super.key, required this.chatRoomName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, ChatProvider chatProvider, consumerWidget) {
            final List<Chat> chats = Provider.of<ChatProvider>(context,
                    listen: false)
                .chats
                .where((element) =>
                    element.chatRoomName == widget.chatRoomName &&
                    element.chatRoomOwner == _auth.currentUser?.email as String)
                .toList();
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return ChatTile(
                          chat: chats[index],
                          owner: _auth.currentUser?.email as String);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            chatProvider.add(Chat(
                              owner: _auth.currentUser?.email as String,
                              text: _textController.text,
                              createdAt: DateTime.now(),
                              chatRoomName: widget.chatRoomName,
                              chatRoomOwner: _auth.currentUser?.email as String,
                            ));
                          }
                          _textController.text = '';
                        },
                        icon: const Icon(Icons.chat),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}