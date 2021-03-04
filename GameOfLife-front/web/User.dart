import 'dart:html';
import 'dart:async';
import 'globals.dart' as globals;
import 'Board.dart';
import 'Brain.dart';

class User {
  var clientRect = globals.ctx.canvas.getBoundingClientRect();
  StreamSubscription<MouseEvent> mouseDownListener;
  StreamSubscription<MouseEvent> startBtnListener;
  StreamSubscription<MouseEvent> nextBtnListener;
  bool hasStarted = false;
  Board board;
  Brain brain;
 
  User() {
    mouseDownListener = globals.ctx.canvas.onMouseDown.listen((event) => mouseDown(event));
    startBtnListener = (querySelector('#start') as ButtonElement ).onClick.listen(toggle);
    nextBtnListener = (querySelector('#next') as ButtonElement ).onClick.listen(next);
    (querySelector('#plus') as ButtonElement ).onClick.listen(addCells);
    (querySelector('#less') as ButtonElement ).onClick.listen(removeCells);
    querySelector('#nb-cells').text = globals.NB_CELLS.toString();
    board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(), (globals.CANVAS_SIZE / globals.CELL_SIZE).round());
    brain = Brain(board);
  }

  void mouseDown(MouseEvent event) {
    event.preventDefault();
    int x = ((event.client.x - clientRect.left) / globals.CELL_SIZE).floor();
    int y = ((event.client.y - clientRect.top) / globals.CELL_SIZE).floor();
    if (board.board[y][x] == 0) {
      board.updateCell(Point(x, y), 1);
    } else {
      board.updateCell(Point(x, y), 0);
    }
  }

  void toggle(MouseEvent event) {
    brain.toggle();
    hasStarted = !hasStarted;
    if (hasStarted) {
      (querySelector('#start') as ButtonElement ).text = 'Stop';
    } else {
      (querySelector('#start') as ButtonElement ).text = 'Start';
    }
  }

  void next(MouseEvent event) {
    brain.step(null);
  }

  void resizeBoard() {
    globals.CANVAS_SIZE = globals.DEFAULT_CANVAS_SIZE;
    globals.CELL_SIZE = (globals.CANVAS_SIZE / globals.NB_CELLS).round();
    // canvas size can be far from 650 when the cell's size is less than 1 but the correct number of cells is drawn anyway
    globals.canvas.height = globals.NB_CELLS * globals.CELL_SIZE;
    globals.canvas.width = globals.NB_CELLS * globals.CELL_SIZE;
    globals.CANVAS_SIZE = globals.canvas.height;
    toggle(null);
    board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(), (globals.CANVAS_SIZE / globals.CELL_SIZE).round());
    brain.reset(board);
  }

  void addCells(MouseEvent event) {
    globals.NB_CELLS++;
    querySelector('#nb-cells').text = globals.NB_CELLS.toString();
    resizeBoard();
  }

  void removeCells(MouseEvent event) {
    if (globals.NB_CELLS > 10) {
      globals.NB_CELLS--;
      querySelector('#nb-cells').text = globals.NB_CELLS.toString();
      resizeBoard();
    }
  }
}