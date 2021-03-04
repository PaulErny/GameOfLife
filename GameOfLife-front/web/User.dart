import 'dart:html';
import 'dart:async';
import 'globals.dart' as globals;
import 'Board.dart';
// import 'Brain.dart';

class User {
  var clientRect = globals.ctx.canvas.getBoundingClientRect();
  StreamSubscription<MouseEvent> mouseDownListener;
  StreamSubscription<MouseEvent> StartBtnListener;
  Board board;
  // Brain brain;
 
  User(this.board) {
    mouseDownListener = globals.ctx.canvas.onMouseDown.listen((event) => mouseDown(event));
    StartBtnListener = (querySelector('#less') as ButtonElement ).onClick.listen(start);
    // brain = Brain();
  }

  void killAsyncTasks() {
    mouseDownListener.cancel();
  }

  void mouseDown(MouseEvent event) {
    print('test');
    event.preventDefault();
    int x = ((event.client.x - clientRect.left) / globals.CELL_SIZE).floor();
    int y = ((event.client.y - clientRect.top) / globals.CELL_SIZE).floor();
    if (board.board[y][x] == 0) {
      board.updateCell(Point(x, y), 1);
    } else {
      board.updateCell(Point(x, y), 0);
    }
  }

  void start(MouseEvent event) {
    // brain.loop();
  }
}