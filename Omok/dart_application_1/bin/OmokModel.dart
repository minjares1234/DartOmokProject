import 'dart:convert';
import 'package:http/http.dart' as http;
import 'OmokView.dart';


class OmokModel {
  String pid = '';  // Unique game ID
  String URL;
  OmokModel(this.URL);

  Future<List<String>> fetchStrategies() async {
    final response = await http.get(Uri.parse('$URL/info/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['strategies']);
    } else {
      throw Exception('Failed to load strategies');
    }
  }

  Future<void> startNewGame(String strategy) async {
    final response = await http.get(Uri.parse('$URL/new/?strategy=$strategy'));
    final data = jsonDecode(response.body);
    if (data['response'] == true) {
      pid = data['pid'];
    } else {
      throw Exception(data['reason']);
    }
  }

  Future<bool> isValidURL(String url) async {
    try {
      // Simulate a network request to check if the URL is valid and has the correct API
      var response = await http.get(Uri.parse('$url/info/'));

      // Check if the response status code indicates success (e.g., 200 OK)
      if (response.statusCode == 200) {
        // Parse the response body to check for the required fields
        var data = jsonDecode(response.body);

        // Check if the expected API fields are present
        if (data != null && data.containsKey('size') && data.containsKey('strategies')) {
          return true; // Return true if the API structure is correct
        } else {
          return false; // Return false if the response does not have the required fields
        }
      } else {
        return false; // Return false for any non-200 status code
      }
    } catch (e) {
      return false; // Return false if any error occurs (e.g., network issues or parsing errors)
    }
  }

  Future<Map<String, dynamic>> makeMove(int x, int y) async {
    final response = await http.get(Uri.parse('$URL/play/?pid=$pid&x=$x&y=$y'));
    return jsonDecode(response.body);
  }
}
