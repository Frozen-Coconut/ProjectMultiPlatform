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
  String dropdownValue = 'eP7G9I6yOj7hNwd_N1UQnc6DyK7tKnjqQ7dKasi2_d4';

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
                  final chatRooms = snapshot.data!;
                  chatRooms.sort((chatRoom1, chatRoom2) =>
                      chatRoom2.updatedAt.compareTo(chatRoom1.updatedAt));
                  return ListView.builder(
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
                final textController = TextEditingController();
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
                      content: DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'eP7G9I6yOj7hNwd_N1UQnc6DyK7tKnjqQ7dKasi2_d4',
                            child: Text('Novel Writing AI'),
                          ),
                          DropdownMenuItem(
                            value: 'qtEICpGfFS8f5Zr5kCHR1EsGsHlawNutYSZJq_IEZDY',
                            child: Text('Pair Programmer'),
                          ),
                          DropdownMenuItem(
                            value: 'W4MWmsvbFFnKF8b9e3Eg6ZUNzdhqvEZYy-tNRtxB_Og',
                            child: Text('Alternate Timeline'),
                          ),DropdownMenuItem(
                            value: 'YntB_ZeqRq2l_aVf2gWDCZl4oBttQzDvhj9cXafWcF8',
                            child: Text('Character Assistant'),
                          ),DropdownMenuItem(
                            value: '9ZSDyg3OuPbFgDqGwy3RpsXqJblE4S1fKA_oU3yvfTM',
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
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Error')));
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

