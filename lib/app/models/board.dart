import 'package:wordle/app/models/board_row.dart';

class Board {
  late final List<BoardRow> _boardRows;
  late final int maxTries;
  int _currentRowIndex = 0;

  Board(
    int wordleLength, {
    this.maxTries = 6,
  }) : assert(maxTries > 0) {
    _boardRows = List.filled(maxTries, BoardRow(wordleLength));
    for (int i = 0; i < _boardRows.length; i++) {
      _boardRows[i] = BoardRow(wordleLength);
    }
  }

  BoardRow get currentRow => _boardRows[_currentRowIndex];
  int get currentRowIndex => _currentRowIndex;

  BoardRow rowAt(int i) => _boardRows[i];
  bool nextRow() {
    if (_currentRowIndex + 1 == maxTries) return false;
    _currentRowIndex += 1;
    return true;
  }
}
