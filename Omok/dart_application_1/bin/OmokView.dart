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
    while (true) {
      stdout.write('Enter strategy (1 or 2): ');
      var line = stdin.readLineSync(); // Read user input
      try {
        int selection = (line != null && line.trim().isNotEmpty)
            ? int.parse(line)
            : 1; // Parse input or use default

        // Check if the input is either 1 or 2
        if (selection == 1 || selection == 2) {
          return selection;
        } else {
          print("Invalid input. Please enter 1 or 2.");
        }
      } catch (e) {
        print("Invalid input. Please enter 1 or 2."); // Handle non-integer input
      }
    }
  }

  // Method to prompt for move coordinates and return them as an array of two integers
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

            // Validate input range and return the coordinates if valid
            if ((x >= xLowerRange && x <= xHigherRange) && (y >= yLowerRange && y <= yHigherRange)) {
              print("You entered: x = $x, y = $y");
              return [x, y];
            } else {
              print("Invalid Index. Coordinates are out of range.");
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

  void displayBoard(List<List<String>> board) {
    // Print column headers
    stdout.write("    ");
    for (int i = 1; i <= board.length; i++) {
      stdout.write('${i.toString().padLeft(2)} ');
    }
    print('');

    // Print rows with row numbers
    for (int i = 0; i < board.length; i++) {
      stdout.write('${(i + 1).toString().padLeft(2)}  ');
      for (int j = 0; j < board[i].length; j++) {
        stdout.write('${board[i][j]}  ');
      }
      print('');
    }
  }

  void displayGameResult(String result) {
    print('Game Over: $result');
  }

  void highlightWinningRow(List<int> winningRow) {
    print('Winning row: $winningRow');
  }
}
