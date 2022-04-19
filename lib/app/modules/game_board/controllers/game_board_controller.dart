import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/app/models/game.dart';
import 'package:wordle/app/models/game_status.dart';
import 'package:wordle/app/models/letter_status.dart';
import 'package:wordle/app/models/statistic.dart';
import 'package:wordle/app/routes/app_pages.dart';
import 'package:wordle/app/services/generator.dart';
import 'package:wordle/app/widgets/end_game_dialog.dart';

class GameBoardController extends GetxController {
  final keyPressed = ''.obs;
  late final Rx<Game> game;
  late final Timer timer;
  late final elapsedTime = ['00', '00', '00'].obs;

  final virtualKeys = {
    'Q': LetterStatus.empty,
    'W': LetterStatus.empty,
    'E': LetterStatus.empty,
    'R': LetterStatus.empty,
    'T': LetterStatus.empty,
    'Y': LetterStatus.empty,
    'U': LetterStatus.empty,
    'I': LetterStatus.empty,
    'O': LetterStatus.empty,
    'P': LetterStatus.empty,
    'A': LetterStatus.empty,
    'S': LetterStatus.empty,
    'D': LetterStatus.empty,
    'F': LetterStatus.empty,
    'G': LetterStatus.empty,
    'H': LetterStatus.empty,
    'J': LetterStatus.empty,
    'K': LetterStatus.empty,
    'L': LetterStatus.empty,
    'Z': LetterStatus.empty,
    'X': LetterStatus.empty,
    'C': LetterStatus.empty,
    'V': LetterStatus.empty,
    'B': LetterStatus.empty,
    'N': LetterStatus.empty,
    'M': LetterStatus.empty,
    'BACKSPACE': LetterStatus.empty,
  }.obs;

  @override
  void onInit() {
    game = Game(Generator().generateWordOfTheDay()).obs;
    timer = Timer.periodic(const Duration(seconds: 1), (time) {
      if (game.value.currentGameStatus == GameStatus.onGoing) {
        final seconds = time.tick % 60;
        final minutes = (time.tick ~/ 60) % 60;
        final hours = (time.tick ~/ 3600);
        elapsedTime.value = [
          (hours < 10) ? '0$hours' : hours.toString(),
          (minutes < 10) ? '0$minutes' : minutes.toString(),
          (seconds < 10) ? '0$seconds' : seconds.toString(),
        ];
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  void boardInput(String key) {
    key = key.toUpperCase();
    if (game.value.currentGameStatus == GameStatus.onGoing) {
      if (RegExp(r'^[A-Z]$').hasMatch(key)) {
        game.update((val) {
          if (val != null) {
            val.board.currentRow.inputLetter(key);
          }
        });
      } else if (key == 'BACKSPACE') {
        game.update((val) {
          if (val != null) {
            val.board.currentRow.removeLetter();
          }
        });
      } else if (key == 'ENTER') {
        game.update((val) {
          if (val != null) {
            final ok = val.submit();
            if (ok) {
              if (game.value.currentGameStatus == GameStatus.win) {
                Get.dialog(
                  EndGameDialog(
                    Statistic(
                      elapsedTime,
                      true,
                      game.value.board.currentRowIndex,
                      game.value.wordle,
                    ),
                  ),
                );
              } else if (game.value.currentGameStatus == GameStatus.lose) {
                Get.dialog(
                  EndGameDialog(
                    Statistic(
                      elapsedTime,
                      false,
                      game.value.board.currentRowIndex,
                      game.value.wordle,
                    ),
                  ),
                );
              } else {
                final board = game.value.board;
                final row = board.rowAt(board.currentRowIndex - 1);
                for (var i = 0; i < row.letters.length; i++) {
                  virtualKeys[row.letters[i]] = row.lettersStatus[i];
                }
              }
            }
          }
        });
      }
    }
  }

  void onKey(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      var key = event.logicalKey;
      keyPressed.value = key.keyLabel;
      boardInput(keyPressed.value);
    }
  }

  void onOpenMenu() {
    Get.dialog(
      Dialog(
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Continue'),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () => Get.snackbar('Feature is not available',
                        'This feature will be implemented in future release'),
                    child: const Text('Setting'),
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed(Routes.HOME),
                    child: const Text('Quit'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }
}
