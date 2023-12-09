import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/chat.dart';
import 'package:whats_ai/chat_tile.dart';
import 'package:whats_ai/provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String owner;

  const ChatScreen({super.key, required this.owner});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Chat> chats =
        Provider.of<ChatProvider>(context, listen: false).chats;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, ChatProvider chatProvider, consumerWidget) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return ChatTile(
                        chat: chats[index],
                        owner: widget.owner,
                      );
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
                              owner: widget.owner,
                              text: _textController.text,
                              createdAt: DateTime.now(),
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
