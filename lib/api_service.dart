import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _apiKey = 'AIzaSyAv4oR4vQe6oy6rH_nJAMsKh4rY5z9nIx0';

  static Future<String> generate(String text) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/gemini-pro:generateContent?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': text}
            ]
          }
        ]
      }),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Some error occurred!');
    }
  }
}
