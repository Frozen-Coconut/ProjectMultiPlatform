import 'dart:convert';

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
            future: ApiService.generate('Hello'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(jsonDecode(snapshot.data as String)['candidates'][0]['content']['parts'][0]['text']),
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
