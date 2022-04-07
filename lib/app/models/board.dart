import 'package:get/get.dart';
import 'package:wordle/app/models/board_row.dart';
import 'package:wordle/app/models/letter_status.dart';

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
  int get rowsLength => _boardRows.length;

  BoardRow rowAt(int i) => _boardRows[i];
  void _addRow() => _boardRows.add(BoardRow(wordle.length));

  List<LetterStatus>? _validateRow(List<String> row, String wordle) {
    if (row.length != wordle.length) {
      return null;
    }
    var letters = wordle.split('');
    var lettersStatus =
        List<LetterStatus>.filled(row.length, LetterStatus.empty);
    for (var i = 0; i < row.length; i++) {
      var letterStatus = LetterStatus.empty;
      if (row[i] == letters[i]) {
        letterStatus = LetterStatus.correct;
      } else if (wordle.contains(row[i])) {
        letterStatus = LetterStatus.wrongPosition;
      } else {
        letterStatus = LetterStatus.wrong;
      }
      lettersStatus[i] = letterStatus;
    }
    return lettersStatus;
  }

  bool submit() {
    if (_boardRows.isNotEmpty &&
        lastRow.currentLetterIndex + 1 <= lastRow.maxLength) {
      Get.snackbar('', 'Not enough letter!', snackPosition: SnackPosition.TOP);
    } else if (_boardRows.length < maxTries) {
      var lettersStatus = _validateRow(lastRow.letters, wordle);
      if (lettersStatus == null) {
        // TODO: Handle validation
      } else {
        lastRow.setLettersStatus(lettersStatus);
        return true;
      }
    }
    return false;
  }
}
