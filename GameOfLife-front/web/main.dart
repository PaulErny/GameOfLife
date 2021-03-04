import 'dart:html';

import './Board.dart';
import 'User.dart';
import 'globals.dart' as globals;

Board board;
User user;

void main() {
    globals.canvas = querySelector('#canvas');
    globals.ctx = globals.canvas.getContext('2d');
    globals.CANVAS_SIZE = globals.DEFAULT_CANVAS_SIZE;
    globals.CELL_SIZE = (globals.CANVAS_SIZE / globals.NB_CELLS).round();

    (querySelector('#plus') as ButtonElement ).onClick.listen(addCells);
    (querySelector('#less') as ButtonElement ).onClick.listen(removeCells);
    querySelector('#nb-cells').text = globals.NB_CELLS.toString();

    globals.canvas.height = globals.NB_CELLS * globals.CELL_SIZE;
    globals.canvas.width = globals.NB_CELLS * globals.CELL_SIZE;
    globals.CANVAS_SIZE = globals.canvas.height;
    board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(), (globals.CANVAS_SIZE / globals.CELL_SIZE).round());

    user = User(board);
}

void addCells(MouseEvent event) {
    globals.NB_CELLS++;
    querySelector('#nb-cells').text = globals.NB_CELLS.toString();
    globals.CANVAS_SIZE = globals.DEFAULT_CANVAS_SIZE;
    globals.CELL_SIZE = (globals.CANVAS_SIZE / globals.NB_CELLS).round();
    // canvas size can be far from 650 when the cell's size is less than 1 but the correct number of cells is drawn anyway
    globals.canvas.height = globals.NB_CELLS * globals.CELL_SIZE;
    globals.canvas.width = globals.NB_CELLS * globals.CELL_SIZE;
    globals.CANVAS_SIZE = globals.canvas.height;
    board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(), (globals.CANVAS_SIZE / globals.CELL_SIZE).round());
    user.killAsyncTasks();
    user = User(board);
}

void removeCells(MouseEvent event) {
    if (globals.NB_CELLS > 10) {
        globals.NB_CELLS--;
        querySelector('#nb-cells').text = globals.NB_CELLS.toString();
        globals.CANVAS_SIZE = globals.DEFAULT_CANVAS_SIZE;
        globals.CELL_SIZE = (globals.CANVAS_SIZE / globals.NB_CELLS).round();
        globals.canvas.height = globals.NB_CELLS * globals.CELL_SIZE;
        globals.canvas.width = globals.NB_CELLS * globals.CELL_SIZE;
        globals.CANVAS_SIZE = globals.canvas.height;
        board = Board((globals.CANVAS_SIZE / globals.CELL_SIZE).round(), (globals.CANVAS_SIZE / globals.CELL_SIZE).round());
        user.killAsyncTasks();
        user = User(board);
    }
}
