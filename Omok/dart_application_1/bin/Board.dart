/// The `Board` class represents the game board for the Omok game.
/// It provides methods to manipulate and display the state of the board.
class Board {
  /// Defines the horizontal range of the board (1 to size).
  final List<int> xRange;

  /// Defines the vertical range of the board (1 to size).
  final List<int> yRange;

  /// A 2D list representing the current state of the game board.
  /// Each cell contains a string representing the state (e.g., '.', 'O', or 'X').
  List<List<String>> board;

  /// Constructor to initialize the board with the given size.
  ///
  /// [size]: The size of the board (e.g., 15 for a 15x15 board).
  Board(int size)
      : xRange = [1, size],
        yRange = [1, size],
        board = List.generate(size, (i) => List.filled(size, '.', growable: false));

  /// Places a stone on the board at the specified coordinates.
  ///
  /// [x]: The x-coordinate (column) where the stone is to be placed.
  /// [y]: The y-coordinate (row) where the stone is to be placed.
  /// [stone]: The string representing the stone ('O', 'X', etc.).
  ///
  /// Returns `true` if the stone was successfully placed; `false` otherwise.
  bool placeStone(int x, int y, String stone) {
    if (x >= xRange[0] && x <= xRange[1] && y >= yRange[0] && y <= yRange[1] && board[x][y] == '.') {
      board[x][y] = stone;
      return true;
    }
    return false; // Return false if the move is invalid or the spot is occupied.
  }

  /// Displays the current state of the board in the console.
  void displayBoard() {
    for (var row in board) {
      print(row.join(' '));
    }
  }

  /// Checks if the specified spot on the board is empty.
  ///
  /// [x]: The x-coordinate (column).
  /// [y]: The y-coordinate (row).
  ///
  /// Returns `true` if the spot is empty (contains '.'); `false` otherwise.
  bool isEmpty(int x, int y) {
    return board[x][y] == '.';
  }

  /// Resets the board to its initial state, clearing all stones.
  void resetBoard() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        board[i][j] = '.';
      }
    }
  }
}
