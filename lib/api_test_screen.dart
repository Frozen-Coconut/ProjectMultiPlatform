import 'package:flutter/material.dart';
import 'package:whats_ai/api_service.dart';

class ApiTestScreen extends StatelessWidget {
  const ApiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            // future: ApiService.generate(
            //     'Hello', 'Novel Writing AI', 'user1@example.com'),
            future: ApiService.history('Novel Writing AI'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(snapshot.data as String),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
