import 'dart:math';
import 'dart:core';
import 'globals.dart' as globals;

class Board {
    int rows;
    int cols;
    var board;

    Board(this.rows, this.cols) {
        var board = List.generate(this.rows, (i) => List.filled(this.cols, 0, growable: false), growable: false);
        board[5][5] = 1;
        
        for (int y=0; y < board.length; y++) {
            for (int x=0; x < board.length; x++) {
                if (board[y][x] == 0) {
                    this.drawCell(new Point(x, y), "white");
                } else {
                    this.drawCell(new Point(x, y), "black");
                }
            }
        }
    }

    void drawCell(Point coords, String color) {
        globals.ctx..fillStyle = color
            ..strokeStyle = "lightgray";

        final int x = coords.x * globals.CELL_SIZE;
        final int y = coords.y * globals.CELL_SIZE;

        globals.ctx..fillRect(x, y, globals.CELL_SIZE, globals.CELL_SIZE)
            ..strokeRect(x, y, globals.CELL_SIZE, globals.CELL_SIZE);
    }

    void clear() {
        globals.ctx..fillStyle = "white"
        ..fillRect(0, 0, globals.CANVAS_SIZE, globals.CANVAS_SIZE);
    }
}