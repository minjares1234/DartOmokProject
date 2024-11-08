import 'OmokModel.dart';
import 'OmokView.dart';
import 'Board.dart';

class OmokController {
  final OmokModel model;
  final OmokView view;
  final Board b;

  OmokController(this.model, this.view, this.b);

  Future<void> startGame() async {
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
      List<String> strategies = await model.fetchStrategies();
      view.displayStrategies(strategies);
      int inputStrategie = view.promptForStrategySelection();

      await model.startNewGame(strategies[inputStrategie - 1]);
      print('New game started with strategy: ${strategies[inputStrategie - 1]}');

      // Game loop
      while (true) {
        view.displayBoard(b.board);
        List<int> move = view.promptMove(b);

        // Adjust indices to be zero-based
        int x = move[0] - 1;
        int y = move[1] - 1;

        if (b.isEmpty(y, x)) { // Correct the order to y (row), x (column)
          b.placeStone(y, x, 'O'); // Place player's stone on the board
          var response = await model.makeMove(x, y); // Ensure correct parameter order

          if (response['response']) {
            int compX = response['move']['x'];
            int compY = response['move']['y'];
            b.placeStone(compY, compX, 'X'); // Place computer's stone on the board

            view.displayBoard(b.board); // Display updated board

            if (response['ack_move']['isWin'] == true) {
              view.displayGameResult('You win!');
              view.highlightWinningRow(response['ack_move']['row']);
              break;
            } else if (response['ack_move']['isDraw'] == true) {
              view.displayGameResult('It\'s a draw!');
              break;
            } else if (response['move']['isWin'] == true) {
              view.displayGameResult('Computer wins!');
              view.highlightWinningRow(response['move']['row']);
              break;
            }
          } else {
            view.displayError(response['reason']);
          }
        } else {
          print("Error: Place not empty, (${y + 1}, ${x + 1})");
        }
      }
    } catch (e) {
      view.displayError(e.toString());
    }
  }
}

