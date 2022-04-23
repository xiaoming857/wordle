import 'package:flutter/foundation.dart';
import 'package:wordle/app/models/board_row.dart';
import 'package:wordle/app/models/letter_status.dart';

class VirtualKeyboardController extends ChangeNotifier {
  final _virtualKeys = <String, LetterStatus>{
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
  };

  String keyAt(int index) {
    if (index < 0) {
      return _virtualKeys.keys.first;
    } else if (index > _virtualKeys.length) {
      return _virtualKeys.keys.last;
    }
    return _virtualKeys.keys.elementAt(index);
  }

  LetterStatus statusAt(String key) {
    key = key.toUpperCase();
    return _virtualKeys[key] ?? LetterStatus.empty;
  }

  bool updateStatus(BoardRow row) {
    for (var i = 0; i < row.letters.length; i++) {
      final letter = row.letters[i];
      final status = row.lettersStatus[i];
      if (_virtualKeys.containsKey(letter) && status != LetterStatus.empty) {
        if (status.index < _virtualKeys[letter]!.index) {
          _virtualKeys[letter] = status;
        }
      } else {
        return false;
      }
    }
    notifyListeners();
    return true;
  }
}
