import 'OmokModel.dart';
import 'OmokView.dart';
import 'OmokController.dart';
import 'Board.dart';

// OmokMain class to initialize and start the Omok game
class OmokMain {
  final OmokModel model;
  final OmokView view;
  final OmokController controller;
  final Board board;

  // Constructor that initializes MVC components
  OmokMain()
      : model = OmokModel(),
        view = OmokView(),
        board = Board(),
        controller = OmokController(OmokModel(), OmokView(), Board());
  // Start method to begin the game process
  Future<void> start() async {
    await controller.startGame(); // Start game by calling controller's method
    controller.moveTile();
  }
}

void main() async {
  OmokMain game =  OmokMain(); // Start game by calling controller's method

  game.start();

}
