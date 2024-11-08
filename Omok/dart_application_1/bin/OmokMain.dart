
import 'Board.dart';

import 'OmokModel.dart';
import 'OmokView.dart';
import 'OmokController.dart';
import 'Board.dart';

void main() async {
  var model = OmokModel("https://www.cs.utep.edu/cheon/cs3360/project/omok");
  var view = OmokView();
  var board = Board(15);
  var controller = OmokController(model, view, board);

  await controller.startGame();
}
