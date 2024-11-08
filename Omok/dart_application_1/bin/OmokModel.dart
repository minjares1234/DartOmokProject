import 'dart:convert';
import 'package:http/http.dart' as http;
import 'OmokView.dart';

/// The `OmokModel` class handles communication with the Omok game server.
/// It manages fetching strategies, starting new games, validating URLs, and making moves.
class OmokModel {
  /// Unique game ID generated when a new game is started.
  String pid = '';

  /// Base URL of the server for Omok game interactions.
  String URL;

  /// Constructor to initialize the `OmokModel` with a server URL.
  OmokModel(this.URL);

  /// Fetches available strategies from the server.
  ///
  /// Returns a [Future] that completes with a list of strategy names.
  /// Throws an [Exception] if the server response is not successful.
  Future<List<String>> fetchStrategies() async {
    final response = await http.get(Uri.parse('$URL/info/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['strategies']);
    } else {
      throw Exception('Failed to load strategies');
    }
  }

  /// Starts a new game with the specified strategy.
  ///
  /// [strategy]: The strategy to use for the new game.
  /// Returns a [Future] that completes when the game is successfully started.
  /// Throws an [Exception] if the server response indicates failure.
  Future<void> startNewGame(String strategy) async {
    final response = await http.get(Uri.parse('$URL/new/?strategy=$strategy'));
    final data = jsonDecode(response.body);
    if (data['response'] == true) {
      pid = data['pid'];
    } else {
      throw Exception(data['reason']);
    }
  }

  /// Checks if the provided URL is valid and points to a compatible Omok server.
  ///
  /// [url]: The server URL to validate.
  /// Returns a [Future] that completes with `true` if the URL is valid and contains the expected API structure, otherwise `false`.
  Future<bool> isValidURL(String url) async {
    try {
      // Simulate a network request to check if the URL is valid and has the correct API.
      var response = await http.get(Uri.parse('$url/info/'));

      // Check if the response status code indicates success (e.g., 200 OK).
      if (response.statusCode == 200) {
        // Parse the response body to check for the required fields.
        var data = jsonDecode(response.body);

        // Check if the expected API fields are present.
        if (data != null && data.containsKey('size') && data.containsKey('strategies')) {
          return true; // Return true if the API structure is correct.
        } else {
          return false; // Return false if the response does not have the required fields.
        }
      } else {
        return false; // Return false for any non-200 status code.
      }
    } catch (e) {
      return false; // Return false if any error occurs (e.g., network issues or parsing errors).
    }
  }

  /// Sends a move to the server and retrieves the response.
  ///
  /// [x]: The x-coordinate of the move.
  /// [y]: The y-coordinate of the move.
  /// Returns a [Future] that completes with a map containing the server's response.
  Future<Map<String, dynamic>> makeMove(int x, int y) async {
    final response = await http.get(Uri.parse('$URL/play/?pid=$pid&x=$x&y=$y'));
    return jsonDecode(response.body);
  }
}

