import 'package:wordle/app/models/board.dart';

class Game {
  late final String wordle;
  late final Board board;

  Game(this.wordle) : assert(wordle.isNotEmpty) {
    board = Board(wordle);
  }
}
