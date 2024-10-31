import 'dart:io';
import 'Board.dart';

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

  // Method to prompt for move coordinates and return them as a string in "x y" format
  List<int> promptMove(Board b) {
    int xLowerRange = b.xRange[0];
    int yLowerRange = b.yRange[0];
    int xHigherRange = b.xRange[1];
    int yHigherRange = b.yRange[1];

    while (true) {
      stdout.write('Enter coordinates of x and y ($xLowerRange - $xHigherRange e.g., "1 2"): '); // Display prompt
      var inputMove = stdin.readLineSync(); // Read input from user

      if (inputMove != null && inputMove.isNotEmpty) {
        var parts = inputMove.split(" "); // Split the input by spaces

        if (parts.length == 2) {
          try {
            int x = int.parse(parts[0]);
            int y = int.parse(parts[1]);

            // Return the coordinates in [x, y] format
            print("You entered: x = $x, y = $y");
            if ((x >= xLowerRange && x <= xHigherRange) && (y >= xLowerRange && y <= xHigherRange)){
              return [x,y];
            }
            else{
              print("Invalid Index");
            }
          } catch (e) {
            print("Invalid input. Please enter two integers separated by a space.");
          }
        } else {
          print("Invalid input format. Please enter two numbers separated by a space.");
        }
      } else {
        print("No input provided.");
      }
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
