import 'dart:math';
import 'dart:core';
import 'globals.dart' as globals;

class Board {
    int rows;
    int cols;
    List _board;

    List get board {
        return _board;
    }

    Board(this.rows, this.cols) {
        _board = List.generate(rows, (i) => List.filled(cols, 0, growable: false), growable: false);
        for (int y=0; y < _board.length; y++) {
            for (int x=0; x < _board.length; x++) {
                if (_board[y][x] == 0) {
                    drawCell(Point(x, y), 'white');
                } else {
                    drawCell(Point(x, y), 'black');
                }
            }
        }
    }

    void drawCell(Point coords, String color) {
        globals.ctx..fillStyle = color
            ..strokeStyle = 'lightgray';

        final int x = coords.x * globals.CELL_SIZE;
        final int y = coords.y * globals.CELL_SIZE;

        globals.ctx..fillRect(x, y, globals.CELL_SIZE, globals.CELL_SIZE)
            ..strokeRect(x, y, globals.CELL_SIZE, globals.CELL_SIZE);
    }

    void clear() {
        globals.ctx..fillStyle = 'white'
        ..fillRect(0, 0, globals.CANVAS_SIZE, globals.CANVAS_SIZE);
    }

    void updateCell(Point coords, int state) {
        if (state == 0) {
            drawCell(coords, 'white');
        } else {
            drawCell(coords, 'black');
        }
    }
}