import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/api_service.dart';
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
            return Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: Provider.of<ChatProvider>(context, listen: false)
                        .getChats(
                            chatRoomName: widget.chatRoomName,
                            chatRoomOwner: _auth.currentUser?.email as String),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final chats = snapshot.data!;
                        chats.sort((chat1, chat2) =>
                            chat2.createdAt.compareTo(chat1.createdAt));
                        return ListView.builder(
                          reverse: true,
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return ChatTile(
                                chat: chats[index],
                                owner: _auth.currentUser?.email as String);
                          },
                        );
                      } else {
                        // return const Center(child: Text('Loading...'));
                        return const Center(child: CircularProgressIndicator());
                      }
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
                        onPressed: () async {
                          if (_textController.text.isNotEmpty) {
                            String text = _textController.text;
                            _textController.text = '';
                            chatProvider.add(Chat(
                              owner: _auth.currentUser?.email as String,
                              text: text,
                              createdAt: DateTime.now(),
                              chatRoomName: widget.chatRoomName,
                              chatRoomOwner: _auth.currentUser?.email as String,
                            ));
                            String response = await ApiService.generate(
                                text,
                                widget.chatRoomName,
                                _auth.currentUser?.email as String);
                            QuerySnapshot querySnapshot =
                            await FirebaseFirestore.instance.collection("chat_rooms").where('name', isEqualTo: widget.chatRoomName).where('owner', isEqualTo: _auth.currentUser?.email as String).get();
                            var docId = querySnapshot.docs.first.id;
                            await FirebaseFirestore.instance.collection("chat_rooms").doc(docId).update({
                                "name": widget.chatRoomName,
                                "owner": _auth.currentUser?.email as String,
                                "updated_at": DateTime.now(),
                            });
                            chatProvider.add(Chat(
                              owner: 'Bot',
                              text: response,
                              createdAt: DateTime.now(),
                              chatRoomName: widget.chatRoomName,
                              chatRoomOwner: _auth.currentUser?.email as String,
                            ));
                          }
                        },
                        icon: const Icon(Icons.send),
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
