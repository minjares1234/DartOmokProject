import 'OmokModel.dart';
import 'OmokView.dart';
import 'OmokController.dart';

// OmokMain class to initialize and start the Omok game
class OmokMain {
  final OmokModel model;
  final OmokView view;
  final OmokController controller;

  // Constructor that initializes MVC components
  OmokMain()
      : model = OmokModel(),
        view = OmokView(),
        controller = OmokController(OmokModel(), OmokView());
  // Start method to begin the game process
  Future<void> start() async {
    await controller.startGame(); // Start game by calling controller's method
  }
}

void main() async {
  OmokMain game =  OmokMain(); // Start game by calling controller's method

  game.start();
}
