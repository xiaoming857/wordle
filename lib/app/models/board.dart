import 'package:wordle/app/models/board_row.dart';

class Board {
  late final String wordle;
  late final int maxTries;
  late final List<BoardRow> _boardRows;

  Board(
    this.wordle, {
    this.maxTries = 6,
  })  : assert(wordle.isNotEmpty),
        assert(maxTries > 0) {
    _boardRows = List.empty(growable: true);
    _addRow();
  }

  BoardRow get lastRow => _boardRows.last;
  BoardRow rowAt(int i) => _boardRows[i];
  int rowsLength() => _boardRows.length;

  bool _addRow() {
    if (_boardRows.length < maxTries) {
      _boardRows.add(BoardRow(wordle));
      return true;
    }
    return false;
  }

  String submit() {
    if (_addRow()) {
      return _boardRows[_boardRows.length - 2].toString();
    }
    return '';
  }
}
