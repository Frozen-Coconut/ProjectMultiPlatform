import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/api_service.dart';
import 'package:whats_ai/chat.dart';
import 'package:whats_ai/chat_room.dart';
import 'package:whats_ai/provider/chat_provider.dart';
import 'package:whats_ai/provider/chat_room_provider.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _auth = FirebaseAuth.instance;
  String dropdownValue = 'Novel Writing AI';
  var _chatRooms = <ChatRoom>[];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomProvider>(
      builder: (context, ChatRoomProvider chatRoomProvider, consumerWidget) {
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
            child: FutureBuilder(
              future: Provider.of<ChatRoomProvider>(context, listen: false)
                  .getChatRooms(owner: _auth.currentUser?.email as String),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  _chatRooms = snapshot.data!;
                  _chatRooms.sort((chatRoom1, chatRoom2) =>
                      chatRoom2.updatedAt.compareTo(chatRoom1.updatedAt));
                  return ListView.builder(
                    itemCount: _chatRooms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_chatRooms[index].name),
                        onTap: () async{
                          await Navigator.pushNamed(context, '/chat',
                              arguments: _chatRooms[index].name);

                          Provider.of<ChatRoomProvider>(context, listen: false)
                              .getChatRooms(owner: _auth.currentUser?.email as String)
                              .then((data){
                                  setState(() {
                                    _chatRooms = data;
                                    _chatRooms.sort((chatRoom1, chatRoom2) =>
                                        chatRoom2.updatedAt.compareTo(chatRoom1.updatedAt));
                                  });
                              });
                        },
                      );
                    },
                  );
                } else {
                  // return const Center(child: Text('Loading...'));
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          floatingActionButton: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add Chat Room'),
                      // content: TextField(
                      //   controller: textController,
                      //   decoration:
                      //       const InputDecoration(labelText: 'Chat Room Name'),
                      // ),
                      content: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        elevation: 16,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'Novel Writing AI',
                            child: Text('Novel Writing AI'),
                          ),
                          DropdownMenuItem(
                            value: 'Pair Programmer',
                            child: Text('Pair Programmer'),
                          ),
                          DropdownMenuItem(
                            value: 'Alternate Timeline',
                            child: Text('Alternate Timeline'),
                          ),
                          DropdownMenuItem(
                            value: 'Character Assistant',
                            child: Text('Character Assistant'),
                          ),
                          DropdownMenuItem(
                            value: 'Creative Helper',
                            child: Text('Creative Helper'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (await chatRoomProvider.add(ChatRoom(
                              owner: _auth.currentUser?.email as String,
                              name: dropdownValue,
                              updatedAt: DateTime.now(),
                            ))) {
                              Provider.of<ChatProvider>(context, listen: false)
                                  .add(Chat(
                                owner: _auth.currentUser?.email as String,
                                text: await ApiService.history(dropdownValue),
                                createdAt: DateTime.now(),
                                chatRoomName: dropdownValue,
                                chatRoomOwner:
                                    _auth.currentUser?.email as String,
                              ));
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error')));
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
          ),
        );
      },
    );
  }
}
