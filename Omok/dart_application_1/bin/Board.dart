class Board {
  // Properties to define the range of the board
  final List<int> xRange;
  final List<int> yRange;

  // The 2D list representing the board state
  List<List<String>> board;

  // Constructor to initialize the board
  Board(int size)
      : xRange = [0, size - 1],
        yRange = [0, size - 1],
        board = List.generate(size, (i) => List.filled(size, '.', growable: false));

  // Method to place a stone on the board
  bool placeStone(int x, int y, String stone) {
    if (x >= xRange[0] && x <= xRange[1] && y >= yRange[0] && y <= yRange[1] && board[x][y] == '.') {
      board[x][y] = stone;
      return true;
    }
    return false; // Invalid move or spot already occupied
  }

  // Method to display the board
  void displayBoard() {
    for (var row in board) {
      print(row.join(' '));
    }
  }

  // Method to check if a spot is empty
  bool isEmpty(int x, int y) {
    return board[x][y] == '.';
  }

  // Method to reset the board
  void resetBoard() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        board[i][j] = '.';
      }
    }
  }
}