import 'OmokModel.dart';
import 'OmokView.dart';
import 'Board.dart';

/// The `OmokController` class is responsible for coordinating the game flow between the model, view, and board.
class OmokController {
  /// The model that handles server communication and game logic.
  final OmokModel model;

  /// The view that handles user input and output.
  final OmokView view;

  /// The board that maintains the current state of the game.
  final Board b;

  /// Constructor for the `OmokController` class.
  OmokController(this.model, this.view, this.b);

  /// Starts the main game loop, handling user input, server communication, and game state updates.
  Future<void> startGame() async {
    // Continuously prompt the user for a valid server URL until successful.
    while (true) {
      var userUrl = view.promptForURL("https://www.cs.utep.edu/cheon/cs3360/project/omok");

      if (Uri.tryParse(userUrl)?.hasAbsolutePath ?? false) {
        if (await model.isValidURL(userUrl)) {
          model.URL = userUrl;
          break;
        } else {
          print("Network error: Unable to connect to the provided URL. Please try again.");
        }
      } else {
        print("Invalid URL format. Please enter a valid URL.");
      }
    }

    try {
      // Fetch available strategies from the server.
      List<String> strategies = await model.fetchStrategies();
      view.displayStrategies(strategies);
      int inputStrategie = view.promptForStrategySelection();

      // Start a new game with the chosen strategy.
      await model.startNewGame(strategies[inputStrategie - 1]);
      print('New game started with strategy: ${strategies[inputStrategie - 1]}');

      // Main game loop.
      while (true) {
        // Display the current board state.
        view.displayBoard(b.board);
        List<int> move = view.promptMove(b);

        // Check if the selected position is empty before placing a stone.
        if (b.isEmpty(move[0], move[1])) {
          b.placeStone(move[0], move[1], 'O'); // Place the player's stone.
          var response = await model.makeMove(move[0], move[1]); // Send the move to the server.

          // Handle server response.
          if (response['response']) {
            b.placeStone(response['move']['x'], response['move']['y'], 'X'); // Place the computer's stone.

            // Check if the game has ended with a win or draw.
            if (response['ack_move']['isWin'] == true) {
              //view.displayGameResult('You win!');
              view.highlightWinningRow(response['ack_move']['row']);
              break;
            } else if (response['ack_move']['isDraw'] == true) {
              //view.displayGameResult('It\'s a draw!');
              break;
            } else if (response['move']['isWin'] == true) {
              //view.displayGameResult('Computer wins!');
              view.highlightWinningRow(response['move']['row']);
              break;
            }
          } else {
            // Display an error message if the server response is negative.
            view.displayError(response['reason']);
          }
        } else {
          // Inform the user if the selected position is already occupied.
          print("Error: Place not empty, (${move[0] + 1}, ${move[1] + 1})");
        }
      }
    } catch (e) {
      // Display any errors that occur during the game.
      view.displayError(e.toString());
    }
  }
}
