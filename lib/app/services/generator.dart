import 'dart:async';

import 'package:english_words/english_words.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class Generator {
  Generator._internal();
  static final _instance = Generator._internal();
  factory Generator() => _instance;

  final List<String> usedWord = [];

  String generateWordOfTheDay() {
    var word = 'HORSE';
    var randomNumber = Random();
    while (word.isEmpty && !usedWord.contains(word)) {
      final words = nouns.where((e) => e.length == 5);
      word = words.elementAt(randomNumber.nextInt(words.length)).toUpperCase();
    }
    usedWord.add(word);
    return word;
  }

  /* void startTimer() { */
  /*   Timer.periodic(const Duration(seconds: 1), (time) { */
  /*     var diff = Jiffy(Jiffy().add(days: 1).format('dd/MM/yyyy'), 'dd/MM/yyyy') */
  /*         .diff(Jiffy(), Units.SECOND) */
  /*         .seconds; */

  /*     var days = diff.inDays; */
  /*     var hours = diff.inHours.remainder(24); */
  /*     var minutes = diff.inMinutes.remainder(60); */
  /*     var seconds = diff.inSeconds.remainder(60); */
  /*     countDown.value = */
  /*         '${days.toString()} day(s) ${hours < 10 ? '0' + hours.toString() : hours} hour(s) ${minutes < 10 ? '0' + minutes.toString() : minutes} minute(s) ${seconds < 10 ? '0' + seconds.toString() : seconds} second(s)'; */
  /*   }); */
  /* } */
}
