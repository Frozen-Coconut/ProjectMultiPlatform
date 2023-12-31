import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/api_test_screen.dart';
import 'package:whats_ai/chat_room_screen.dart';
import 'package:whats_ai/chat_screen.dart';
import 'package:whats_ai/firebase_options.dart';
import 'package:whats_ai/login_screen.dart';
import 'package:whats_ai/provider/chat_provider.dart';
import 'package:whats_ai/provider/chat_room_provider.dart';
import 'package:whats_ai/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatRoomProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple
          ),

          useMaterial3: true,
        ),
        routes: {
          '/register': (context) => const RegisterScreen(),
          '/login': (context) => const LoginScreen(),
          '/chatroom': (context) => const ChatRoomScreen(),
          '/chat': (context) => ChatScreen(
              chatRoomName:
                  ModalRoute.of(context)?.settings.arguments as String),
          '/apitest': (context) => const ApiTestScreen(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
