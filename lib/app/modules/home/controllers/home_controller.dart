import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/app/models/board.dart';
import 'package:wordle/app/services/generator.dart';

class HomeController extends GetxController {
  final keyPressed = ''.obs;
  late final Rx<Board> board;

  @override
  void onInit() {
    board = Board(Generator().generateWordOfTheDay()).obs;
    super.onInit();
  }

  void onKey(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      var key = event.logicalKey;
      keyPressed.value = key.keyLabel;
      debugPrint(key.keyLabel);
      if (RegExp(r'^[A-Z]$').hasMatch(key.keyLabel.toUpperCase())) {
        board.update((val) {
          if (val != null) {
            val.lastRow.inputLetter(key.keyLabel);
          }
        });
      } else if (key == LogicalKeyboardKey.backspace) {
        board.update((val) {
          if (val != null) {
            val.lastRow.removeLetter();
          }
        });
      } else if (key == LogicalKeyboardKey.enter) {
        board.value.submit();
      }
    }
  }
}
