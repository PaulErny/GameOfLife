import 'dart:async';
import 'dart:math';
import 'Board.dart';
import 'globals.dart' as globals;

class Brain {
  bool _shouldStop = true;
  Board _board;
  /// containes the black cells to be drawn on the next iteration
  List<Point> _nextDarkCells;
  /// containes the black cells that have been reverted to wihte to be drawn on the next iteration
  List<Point> _nextWhiteCells;

  bool get isStopped {
    return _shouldStop;
  }

  Brain(this._board) {
    _nextDarkCells = [];
    _nextWhiteCells = [];
  }

  /// resets the brain for a new start
  void reset(Board board) {
    _shouldStop = true;
    _nextWhiteCells.clear();
    _nextDarkCells.clear();
    _board = board;
  }

  /// Starts the simulation in loop mode by triggering this.step() every globals.TURN_TIME ms
  void toggle() {
    _shouldStop = !_shouldStop;
    Timer.periodic(Duration(milliseconds: globals.TURN_TIME), step);
  }

  /// Triggers one iteration of the algorithm
  void step(Timer timer) {
    _nextDarkCells.clear();
    _nextWhiteCells.clear();
    if (timer != null && _shouldStop) {
      timer.cancel();
    }
    // if a black cell has less than 2 or more the 3 neighbours, it is reverted to white
    // otherwise, it remains black 
    for (Point cell in _board.darkPoints) {
      int count = countNeighbours(cell);
      if (count < 2 || count > 3) {
        _nextWhiteCells.add(cell);
      } else {
        _nextDarkCells.add(cell);
      }
    }
    // if a white cell has 3 neighbours, it will be black on the next iteration
    for (Point cell in _board.adjacentWhitePoints) {
      int count = countNeighbours(cell);
      if (count == 3) {
        _nextDarkCells.add(cell);
      }
    }
    _board.update(_nextDarkCells, _nextWhiteCells);
  }

  /// returns the number of cells adjacent to the one at position $coords
  int countNeighbours(Point coords) {
    int score = 0;

    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        int x = coords.x + i;
        int y = coords.y + j;
        if (x >= 0 && x < _board.cols && y >= 0 && y < _board.rows) {
          score += _board.board[y][x];
        }
      }
    }
    return score - _board.board[coords.y][coords.x];
  }
}
