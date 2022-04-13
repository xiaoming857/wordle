import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/app/models/game.dart';
import 'package:wordle/app/models/game_status.dart';
import 'package:wordle/app/services/generator.dart';

class GameBoardController extends GetxController {
  final keyPressed = ''.obs;
  late final Rx<Game> game;

  @override
  void onInit() {
    game = Game(Generator().generateWordOfTheDay()).obs;
    super.onInit();
  }

  void onKey(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      var key = event.logicalKey;
      keyPressed.value = key.keyLabel;
      if (game.value.currentGameStatus == GameStatus.onGoing) {
        if (RegExp(r'^[A-Z]$').hasMatch(key.keyLabel.toUpperCase())) {
          game.update((val) {
            if (val != null) {
              val.board.currentRow.inputLetter(key.keyLabel);
            }
          });
        } else if (key == LogicalKeyboardKey.backspace) {
          game.update((val) {
            if (val != null) {
              val.board.currentRow.removeLetter();
            }
          });
        } else if (key == LogicalKeyboardKey.enter) {
          game.value.submit();
        }
      }
    }
  }
}
