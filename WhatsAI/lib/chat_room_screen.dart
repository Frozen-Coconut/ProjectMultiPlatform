import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/chat_room.dart';
import 'package:whats_ai/provider/chat_room_provider.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomProvider>(
      builder: (context, ChatRoomProvider chatRoomProvider, consumerWidget) {
        final List<ChatRoom> chatRooms =
            Provider.of<ChatRoomProvider>(context, listen: false)
                .chats
                .where((element) => element.owner == _auth.currentUser?.email)
                .toList();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout),
            ),
            title: const Text('Chat Room'),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatRooms[index].name),
                  onTap: () {
                    Navigator.pushNamed(context, '/chat',
                        arguments: chatRooms[index].name);
                  },
                );
              },
            ),
          ),
          floatingActionButton: IconButton(
            onPressed: () {
              final textController = TextEditingController();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Add Chat Room'),
                    content: TextField(
                      controller: textController,
                      decoration:
                          const InputDecoration(labelText: 'Chat Room Name'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (textController.text.isEmpty) return;
                          if (chatRoomProvider.add(ChatRoom(
                            owner: _auth.currentUser?.email as String,
                            name: textController.text,
                          ))) {
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Invalid Chat Room Name')));
                          }
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
