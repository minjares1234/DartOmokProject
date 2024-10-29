import 'dart:convert';
import 'package:http/http.dart' as http;

// OmokModel class handles game data and server communication
class OmokModel {
  // Default URL for the server that provides Omok strategies
  final String defaultURL =
      'https://www.cs.utep.edu/cheon/cs3360/project/omok/info/';

  // List to store strategies retrieved from the server
  List<String> strategies = [];

  // Method to fetch strategies from the server using the provided URL
  Future<void> fetchStrategies(String url) async {
    print("Fetching strategies from URL: $url"); // Log URL for debugging
    var response = await http.get(Uri.parse(url)); // Make HTTP GET request

    if (response.statusCode == 200) {
      // Check if response is successful
      print("Response received: ${response.body}"); // Log response body
      var info = jsonDecode(response.body); // Decode JSON response
      if (info != null && info['strategies'] != null) {
        // Check if data format is valid
        strategies =
            List<String>.from(info['strategies']); // Extract strategies
      } else {
        throw Exception(
            "Invalid data format."); // Throw error if data is invalid
      }
    } else {
      throw Exception(
          "Failed to connect to the server."); // Handle failed request
    }
  }
}
