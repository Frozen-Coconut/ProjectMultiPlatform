import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiUrl = 'https://backend-cc-2fjlhhtoeq-et.a.run.app';

  static Future<String> generate(
      String text, String characterName, String email) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'message': text, 'character_name': characterName, 'email': email}),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Some error occurred!');
    }
  }

  static void login() async{
    await http.post(
      Uri.parse('$_apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<String> history(String characterName) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/history'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'character_name': characterName}),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Some error occurred!');
    }
  }
}
