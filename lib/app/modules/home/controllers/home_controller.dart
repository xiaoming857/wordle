import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wordle/app/services/generator.dart';

class HomeController extends GetxController {
  late final String wordOfTheDay;
  final word = <String>[].obs;
  final keyPressed = ''.obs;
  int currentIndex = 0;

  @override
  void onInit() {
    wordOfTheDay = Generator().generateWordOfTheDay();
    word.value = List<String>.filled(wordOfTheDay.length, '');
    super.onInit();
  }

  void onKey(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      var key = event.logicalKey;
      keyPressed.value = key.keyLabel;
      debugPrint(key.keyLabel);
      if (RegExp(r'^[A-Z]$').hasMatch(key.keyLabel.toUpperCase())) {
        if (currentIndex <= wordOfTheDay.length) {
          word[currentIndex] = key.keyLabel;
          currentIndex += 1;
        }
      } else if (key == LogicalKeyboardKey.enter) {
      } else if (key == LogicalKeyboardKey.backspace) {
        if (currentIndex > 0) {
          currentIndex -= 1;
          word[currentIndex] = '';
        }
      }
    }
  }
}
