import 'dart:io';
import 'Board.dart';

/// The `OmokView` class handles user interactions and game output for the Omok game.
class OmokView {
  /// Prompts the user for the server URL.
  ///
  /// If the user input is empty, the [defaultURL] will be returned.
  ///
  /// Returns a [String] representing the URL provided by the user or the default URL.
  String promptForURL(String defaultURL) {
    stdout.write('Enter the server URL [default: $defaultURL]: ');
    var inputUrl = stdin.readLineSync();
    return (inputUrl != null && inputUrl.isNotEmpty) ? inputUrl : defaultURL;
  }

  /// Displays available strategies for the user to choose from.
  ///
  /// [strategies] is a list of available strategy names.
  void displayStrategies(List<String> strategies) {
    stdout.write('Select a server strategy: ');
    for (var i = 0; i < strategies.length; i++) {
      stdout.write('${i + 1}. ${strategies[i]} ');
    }
    stdout.write('[default: 1]: ');
  }

  /// Prompts the user to select a strategy.
  ///
  /// Repeatedly prompts until a valid selection (1 or 2) is made.
  /// Returns an [int] representing the user's selection.
  int promptForStrategySelection() {
    while (true) {
      stdout.write('Enter strategy (1 or 2): ');
      var line = stdin.readLineSync();
      try {
        int selection = (line != null && line.trim().isNotEmpty)
            ? int.parse(line)
            : 1; // Default to 1 if input is empty

        if (selection == 1 || selection == 2) {
          return selection;
        } else {
          print("Invalid input. Please enter 1 or 2.");
        }
      } catch (e) {
        print("Invalid input. Please enter 1 or 2.");
      }
    }
  }

  /// Prompts the user for move coordinates.
  ///
  /// Validates the input to ensure it is within the board range.
  ///
  /// Returns a [List<int>] containing the x and y coordinates of the move.
  List<int> promptMove(Board b) {
    int xLowerRange = b.xRange[0];
    int yLowerRange = b.yRange[0];
    int xHigherRange = b.xRange[1];
    int yHigherRange = b.yRange[1];

    while (true) {
      stdout.write('Enter coordinates of x and y ($xLowerRange - $xHigherRange e.g., "1 2"): ');
      var inputMove = stdin.readLineSync();

      if (inputMove != null && inputMove.isNotEmpty) {
        var parts = inputMove.split(" ");

        if (parts.length == 2) {
          try {
            int x = int.parse(parts[0]);
            int y = int.parse(parts[1]);

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

  /// Displays an error message.
  ///
  /// [message] is the error message to be displayed.
  void displayError(String message) {
    print("Error: $message");
  }

  /// Displays a message confirming the creation of a new game.
  ///
  /// [strategy] is the selected strategy for the game.
  void displayGameCreation(String strategy) {
    print("Creating new game with strategy: $strategy");
  }

  /// Displays the current state of the game board.
  ///
  /// [board] is a 2D list representing the current game state.
  void displayBoard(List<List<String>> board) {
    stdout.write("    ");
    for (int i = 1; i <= board.length; i++) {
      stdout.write('${i.toString().padLeft(2)} ');
    }
    print('');

    for (int i = 0; i < board.length; i++) {
      stdout.write('${(i + 1).toString().padLeft(2)}  ');
      for (int j = 0; j < board[i].length; j++) {
        stdout.write('${board[i][j]}  ');
      }
      print('');
    }
  }

  /// Displays the result of the game and highlights the winning row.
  ///
  /// [result] is the final result message.
  /// [board] is the current state of the board.
  /// [winningRow] contains the coordinates of the winning row.
  void displayGameResult(String result, List<List<String>> board, List<int>? winningRow) {
    print('Game Over: $result');
    if (winningRow != null) {
      for (var index in winningRow) {
        int x = index ~/ board.length;
        int y = index % board.length;
        board[x][y] = board[x][y].toUpperCase();
      }
    }
    displayBoard(board);
  }

  /// Highlights the winning row.
  ///
  /// [winningRow] contains the coordinates of the winning row.
  void highlightWinningRow(List<int> winningRow) {
    print('Winning row: $winningRow');
  }
}
