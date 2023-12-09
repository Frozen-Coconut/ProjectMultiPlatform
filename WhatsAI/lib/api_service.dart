import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiUrl = 'API_URL';
  static const String _apiKey = 'API_KEY';

  Future<String> get() async {
    final response = await http.get(Uri.parse('$_apiUrl?key=$_apiKey'));
    if (response.statusCode == 200) {
      return response.toString();
    } else {
      throw Exception('Some error occurred!');
    }
  }
}
