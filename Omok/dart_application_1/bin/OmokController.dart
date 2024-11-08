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
        if (b.isEmpty(move[0], move[1])) {
          b.placeStone(move[0], move[1], 'O');
          var response = await model.makeMove(move[0], move[1]);

          if (response['response']) {
            b.placeStone(response['move']['x'], response['move']['y'], 'X');
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
          print("Error: Place not empty, (${move[0] + 1}, ${move[1] + 1})");
        }
      }
    } catch (e) {
      view.displayError(e.toString());
    }
  }




}
