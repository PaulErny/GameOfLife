import 'dart:math';
import 'dart:core';
import 'globals.dart' as globals;

class Board {
  int _rows;
  int _cols;
  List<List<int>> _board;
  List<Point> _darkPoints;
  List<Point> _adjacentWhitePoints;

  int get rows {
    return _rows;
  }

  int get cols {
    return _cols;
  }

  List<Point> get darkPoints {
    return _darkPoints;
  }

  List<Point> get adjacentWhitePoints {
    return _adjacentWhitePoints;
  }

  List<List<int>> get board {
    return _board;
  }

  Board(this._rows, this._cols) {
    _darkPoints = [];
    _adjacentWhitePoints = [];
    _board = List.generate(_rows, (i) => List.filled(_cols, 0, growable: false),
        growable: false);
    for (int y = 0; y < _board.length; y++) {
      for (int x = 0; x < _board.length; x++) {
        if (_board[y][x] == 0) {
          drawCell(Point(x, y), 'white');
        } else {
          drawCell(Point(x, y), 'black');
        }
      }
    }
  }

  /// draws a cell at position $coords (relative to tu number of cells, not absolute px position)
  void drawCell(Point coords, String color) {
    globals.ctx
      ..fillStyle = color
      ..strokeStyle = 'lightgray';

    final int x = coords.x * globals.CELL_SIZE;
    final int y = coords.y * globals.CELL_SIZE;

    globals.ctx
      ..fillRect(x, y, globals.CELL_SIZE, globals.CELL_SIZE)
      ..strokeRect(x, y, globals.CELL_SIZE, globals.CELL_SIZE);
  }

  /// clears the canvas
  void clear() {
    globals.ctx
      ..fillStyle = 'white'
      ..fillRect(0, 0, globals.CANVAS_SIZE, globals.CANVAS_SIZE);
  }

  /// draws all cells contained in $nextDarkCells and $nextWhiteCells on the canvas, respectively in black and white
  void update(List<Point> nextDarkCells, List<Point> nextWhiteCells) {
    for (Point cell in nextDarkCells) {
      updateCell(cell, 1);
    }
    for (Point cell in nextWhiteCells) {
      updateCell(cell, 0);
    }
  }

  // updates the given $cell to the given $state on the canvas and adds it in memory if needed
  void updateCell(Point coords, int state) {
    _board[coords.y][coords.x] = state;
    if (state == 0) {
      _darkPoints.remove(coords);
      drawCell(coords, 'white');
      for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
          int x = coords.x + i;
          int y = coords.y + j;
          if (x >= 0 && x < _cols && y >= 0 && y < _rows) {
            _adjacentWhitePoints.remove(Point(x, y));
          }
        }
      }
    } else {
      if (_darkPoints.contains(coords) == false) {
        _darkPoints.add(coords);
        drawCell(coords, 'black');
        // add adjacent white points
        // a cell may be added several times
        // this is needed to reduce computation time when removing the white cells adjacent to a removed black cell
        for (int i = -1; i < 2; i++) {
          for (int j = -1; j < 2; j++) {
            int x = coords.x + i;
            int y = coords.y + j;
            if (x >= 0 && x < _cols && y >= 0 && y < _rows) {
              _adjacentWhitePoints.add(Point(x, y));
            }
          }
        }
      }
    }
  }
}
