import 'dart:html';
import 'globals.dart' as globals;
import 'Board.dart';
import 'Brain.dart';

class User {
  var _clientRect;
  bool _hasStarted = false;
  Board _board;
  Brain _brain;

  User() {
    _clientRect = globals.ctx.canvas.getBoundingClientRect();
    globals.ctx.canvas.onMouseDown.listen(placeCell);
    (querySelector('#start') as ButtonElement).onClick.listen(toggle);
    (querySelector('#next') as ButtonElement).onClick.listen(next);
    (querySelector('#plus') as ButtonElement).onClick.listen(addCells);
    (querySelector('#less') as ButtonElement).onClick.listen(removeCells);
    querySelector('#nb-cells').text = globals.NB_CELLS.toString();
    _board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(),
        (globals.CANVAS_SIZE / globals.CELL_SIZE).round());
    _brain = Brain(_board);
  }

  /// place a cell on the position of the mouse click
  void placeCell(MouseEvent event) {
    event.preventDefault();
    int x = ((event.client.x - _clientRect.left) / globals.CELL_SIZE).floor();
    int y = ((event.client.y - _clientRect.top) / globals.CELL_SIZE).floor();
    if (_board.board[y][x] == 0) {
      _board.updateCell(Point(x, y), 1);
    } else {
      _board.updateCell(Point(x, y), 0);
    }
  }

  /// Start / stop the algorithm in endless loop mode
  void toggle(MouseEvent event) {
    _brain.toggle();
    _hasStarted = !_hasStarted;
    if (_hasStarted) {
      (querySelector('#start') as ButtonElement).text = 'Stop';
      (querySelector('#start') as ButtonElement).style.background = 'linear-gradient(#e54e4e 0%,#d53838 100%)';
      (querySelector('#start') as ButtonElement).style.borderBottom = '4px solid #c62b2b';
    } else {
      (querySelector('#start') as ButtonElement).text = 'Start';
      (querySelector('#start') as ButtonElement).style.background = 'linear-gradient(#4eb5e5 0%,#389ed5 100%)';
      (querySelector('#start') as ButtonElement).style.borderBottom = '4px solid #2b8ac6';
    }
  }

  /// Triggers one computation of the algorithm
  void next(MouseEvent event) {
    _brain.step(null);
  }

  /// recreates a board with the amount of cells the user wants
  void resizeBoard() {
    globals.CANVAS_SIZE = globals.DEFAULT_CANVAS_SIZE;
    globals.CELL_SIZE = (globals.CANVAS_SIZE / globals.NB_CELLS).round();
    // canvas size can be far from 650 when the cell's size is less than 1 but the correct number of cells is drawn anyway
    globals.canvas.height = globals.NB_CELLS * globals.CELL_SIZE;
    globals.canvas.width = globals.NB_CELLS * globals.CELL_SIZE;
    globals.CANVAS_SIZE = globals.canvas.height;
    toggle(null);
    _board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(),
        (globals.CANVAS_SIZE / globals.CELL_SIZE).round());
    _brain.reset(_board);
  }

  /// increases the amount of cells on the board by 1 row and 1 column
  void addCells(MouseEvent event) {
    globals.NB_CELLS++;
    querySelector('#nb-cells').text = globals.NB_CELLS.toString();
    resizeBoard();
  }

  /// decreases the amount of cells on the board by 1 row and 1 column
  void removeCells(MouseEvent event) {
    if (globals.NB_CELLS > 10) {
      globals.NB_CELLS--;
      querySelector('#nb-cells').text = globals.NB_CELLS.toString();
      resizeBoard();
    }
  }
}
