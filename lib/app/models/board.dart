import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/app/models/board_row.dart';
import 'package:wordle/app/models/letter_status.dart';

class Board {
  late final String wordle;
  late final int maxTries;
  late final List<BoardRow> _boardRows;
  int _currentRowIndex = 0;

  Board(
    this.wordle, {
    this.maxTries = 6,
  })  : assert(wordle.isNotEmpty),
        assert(maxTries > 0) {
    _boardRows = List.filled(maxTries, BoardRow(wordle.length));
    for (int i = 0; i < _boardRows.length; i++) {
      _boardRows[i] = BoardRow(wordle.length);
    }
  }

  BoardRow get currentRow => _boardRows[_currentRowIndex];
  int get currentRowIndex => _currentRowIndex;
  int get rowsLength => _boardRows.length;

  BoardRow rowAt(int i) => _boardRows[i];

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
    if (currentRow.currentLetterIndex < currentRow.maxLength) {
      Get.snackbar(
        'Warning',
        'Not enough letter!',
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      );
    } else if (_currentRowIndex < maxTries) {
      if (!nouns.contains(currentRow.toString().toLowerCase())) {
        Get.snackbar(
          'Warning',
          'Word does not exists!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.5),
          margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        );
      } else {
        var lettersStatus = _validateRow(currentRow.letters, wordle);
        if (lettersStatus == null) {
          // TODO: Handle validation
        } else {
          rowAt(_currentRowIndex).setLettersStatus(lettersStatus);
          _currentRowIndex += 1;
          return true;
        }
      }
    }
    return false;
  }
}
