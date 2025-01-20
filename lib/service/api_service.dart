import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          return response.body;
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers ?? {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Kiểm tra nếu body là JSON hợp lệ
      try {
        return jsonDecode(response.body);
      } catch (e) {
        // Nếu không phải JSON, trả về chuỗi thô
        return response.body;
      }
    } else {
      throw Exception('Failed to post data: ${response.statusCode}');
    }
  }

}

