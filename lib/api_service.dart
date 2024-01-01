import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiUrl = 'http://localhost:3000';

  static Future<String> generate(
      String text, String characterName, String email) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': text,
        'character_name': characterName,
        'email': email
      }),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Some error occurred!');
    }
  }
}
