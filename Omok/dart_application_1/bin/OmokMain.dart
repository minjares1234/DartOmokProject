/// Entry point for the Omok game.
///
/// This function initializes the main components of the game: the model, view, board, and controller.
/// It then starts the game using the controller.
import 'Board.dart';
import 'OmokModel.dart';
import 'OmokView.dart';
import 'OmokController.dart';

void main() async {
  // Initialize the Omok game model with the default server URL.
  var model = OmokModel("https://www.cs.utep.edu/cheon/cs3360/project/omok");

  // Initialize the Omok game view for user interactions.
  var view = OmokView();

  // Initialize the board with a size of 15x15.
  var board = Board(15);

  // Create the Omok controller, which manages the game flow and interactions between the model, view, and board.
  var controller = OmokController(model, view, board);

  // Start the game by calling the controller's startGame method.
  await controller.startGame();
}

