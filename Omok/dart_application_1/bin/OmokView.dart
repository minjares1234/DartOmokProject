import 'dart:io';

// OmokView class handles user input and output
class OmokView {
  // Method to prompt user for the server URL
  String promptForURL(String defaultURL) {
    stdout.write(
        'Enter the server URL [default: $defaultURL]: '); // Display prompt
    var inputUrl = stdin.readLineSync(); // Read input from user
    // Return user input or default URL if input is empty
    return (inputUrl != null && inputUrl.isNotEmpty) ? inputUrl : defaultURL;
  }

  // Method to display available strategies to the user
  void displayStrategies(List<String> strategies) {
    stdout.write('Select a server strategy: '); // Display prompt for selection
    for (var i = 0; i < strategies.length; i++) {
      stdout.write('${i + 1}. ${strategies[i]} '); // List strategies
    }
    stdout.write('[default: 1]: '); // Prompt for default choice
  }

  // Method to prompt user for strategy selection and return selection as an integer
  int promptForStrategySelection() {
    var line = stdin.readLineSync(); // Read user input
    try {
      return (line != null && line.trim().isNotEmpty)
          ? int.parse(line)
          : 1; // Parse input or use default
    } catch (e) {
      print("Invalid input. Defaulting to strategy 1."); // Handle invalid input
      return 1; // Return default if parsing fails
    }
  }

  // Method to display error messages
  void displayError(String message) {
    print("Error: $message"); // Print error message
  }

  // Method to confirm the game creation with the selected strategy
  void displayGameCreation(String strategy) {
    print(
        "Creating new game with strategy: $strategy"); // Print game creation message
  }
}
