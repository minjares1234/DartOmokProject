import 'OmokModel.dart';
import 'OmokView.dart';
import 'Board.dart';

// OmokController coordinates the Model and View to handle game logic
class OmokController {
  final OmokModel model; // Reference to the model for data handling
  final OmokView view; // Reference to the view for user interaction
  final Board board;

  // Constructor that initializes model and view references
  OmokController(this.model, this.view, this.board);

  // Main method to start the game and fetch strategies
  Future<void> startGame() async {
    var url = view.promptForURL(model.defaultURL); // Get URL input from user
    try {
      print("Starting game and fetching strategies..."); // Log action
      await model.fetchStrategies(url); // Fetch strategies from server

      if (model.strategies.isNotEmpty) {
        // Check if strategies are available
        view.displayStrategies(model.strategies); // Show strategies to user
        var selection = view.promptForStrategySelection(); // Get user selection

        if (selection > 0 && selection <= model.strategies.length) {
          view.displayGameCreation(
              model.strategies[selection - 1]); // Confirm selection
        } else {
          view.displayError(
              "Invalid strategy selection."); // Handle invalid selection
        }
      } else {
        view.displayError(
            "No strategies available."); // Handle empty strategy list
      }
    } catch (e) {
      view.displayError(e.toString()); // Display any errors encountered
    }
  }

  void moveTile(){
    var m = view.promptMove(board);
  }


}
