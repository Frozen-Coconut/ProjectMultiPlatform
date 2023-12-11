import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_ai/provider/user_provider.dart';
import 'package:whats_ai/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<User> users =
        Provider.of<UserProvider>(context, listen: false).users;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _usernameTextController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  User user;
                  try {
                    user = users.firstWhere((User user) =>
                        user.username == _usernameTextController.text);
                  } catch (exception) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User does not exist!')));
                    return;
                  }
                  if (!user.checkPassword(_passwordTextController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid password!')));
                    return;
                  }
                  Navigator.pushNamed(context, '/chat',
                      arguments: user.username);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
