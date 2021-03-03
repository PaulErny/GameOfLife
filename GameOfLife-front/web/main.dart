import 'dart:html';
import 'dart:math';

CanvasElement canvas;    
CanvasRenderingContext2D ctx;

const int CELL_SIZE = 10;

void main() {
    canvas = querySelector('#canvas');
    ctx = canvas.getContext('2d');
    drawCell(new Point(10, 10), "black");
}

void drawCell(Point coords, String color) {
    ctx..fillStyle = color
        ..strokeStyle = "white";

    final int x = coords.x * CELL_SIZE;
    final int y = coords.y * CELL_SIZE;

    ctx..fillRect(x, y, CELL_SIZE, CELL_SIZE)
        ..strokeRect(x, y, CELL_SIZE, CELL_SIZE);
}