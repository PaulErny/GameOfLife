import 'dart:async';
import 'dart:math';
import 'Board.dart';

class Brain {
  bool shouldStop = true;
  Board board;
  List<Point> nextDarkCells;
  List<Point> nextWhiteCells;

  bool get isStopped {
    return shouldStop;
  }

  Brain(this.board) {
    nextDarkCells = [];
    nextWhiteCells = [];
  }
  
  void reset(Board board) {
    shouldStop = true;
    nextWhiteCells.clear();
    nextDarkCells.clear();
    this.board = board;
  }

  void toggle() {
    shouldStop = !shouldStop;
    Timer.periodic(Duration(milliseconds: 500), step);
  }

  void step(Timer timer) {
    nextDarkCells.clear();
    nextWhiteCells.clear();
    if (timer != null && shouldStop) {
      timer.cancel();
    }
    for (Point cell in board.darkPoints) {
      int count = countNeighbours(cell);
      if (count < 2 || count > 3) {
        // will be white -> not added to board._nextDarkPoints
        nextWhiteCells.add(cell);
      } else {
        nextDarkCells.add(cell);
      }
    }
    for (Point cell in board.adjacentWhitePoints) {
      int count = countNeighbours(cell);
      if (count == 3) {
        nextDarkCells.add(cell);
      }
    }
    board.update(nextDarkCells, nextWhiteCells);
  }

  int countNeighbours(Point coords) {
    int score = 0;

    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        int x = coords.x + i;
        int y = coords.y + j;
        if (x >= 0 && x < board.cols && y >= 0 && y < board.rows) {
          score += board.board[y][x];
        }
      }    
    }
    return score - board.board[coords.y][coords.x];
  }
}