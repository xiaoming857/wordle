import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/app/models/board.dart';
import 'package:wordle/app/models/game_status.dart';
import 'package:wordle/app/models/letter_status.dart';
import 'package:wordle/app/widgets/game_dialog.dart';

class Game {
  late final String wordle;
  late final Board board;
  var _currentGameStatus = GameStatus.onGoing;

  GameStatus get currentGameStatus => _currentGameStatus;

  Game(this.wordle) : assert(wordle.isNotEmpty) {
    board = Board(wordle.length);
  }

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
    if (!board.currentRow.isFilled) {
      Get.snackbar(
        'Warning',
        'Not enough letter!',
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      );
    } else if (board.currentRowIndex < board.maxTries) {
      if (!nouns.contains(board.currentRow.toString().toLowerCase())) {
        Get.snackbar(
          'Warning',
          'Word does not exists!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.5),
          margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        );
      } else {
        var lettersStatus = _validateRow(board.currentRow.letters, wordle);
        if (lettersStatus == null) {
          // TODO: Handle validation
        } else {
          board.rowAt(board.currentRowIndex).setLettersStatus(lettersStatus);
          if (lettersStatus.every((e) => e == LetterStatus.correct)) {
            _currentGameStatus = GameStatus.win;
            Get.dialog(const GameDialog(
              'Congratulation!',
              contents: [
                Text('You have successfully guessed the wordle of the day!'),
              ],
            ));
          } else if (!board.nextRow()) {
            _currentGameStatus = GameStatus.lose;
            Get.dialog(GameDialog(
              'Try again next time!',
              contents: [
                const Text('You failed to guess the wordle of the day!'),
                const Text('The wordle of the day is:'),
                Text(
                  wordle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ));
          }
          return true;
        }
      }
    }
    return false;
  }
}
