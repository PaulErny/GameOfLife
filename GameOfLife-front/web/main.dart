import 'dart:html';
import 'User.dart';
import 'globals.dart' as globals;

void main() {
  globals.canvas = querySelector('#canvas');
  globals.ctx = globals.canvas.getContext('2d');
  globals.CANVAS_SIZE = globals.DEFAULT_CANVAS_SIZE;
  globals.CELL_SIZE = (globals.CANVAS_SIZE / globals.NB_CELLS).round();

  // depending on the number and size of cells, a row / col may not fit in the canvas -> adjust the canvas size
  globals.canvas.height = globals.NB_CELLS * globals.CELL_SIZE;
  globals.canvas.width = globals.NB_CELLS * globals.CELL_SIZE;
  globals.CANVAS_SIZE = globals.canvas.height;

  User user = User();
}
