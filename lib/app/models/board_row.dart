import 'package:wordle/app/models/letter_status.dart';

class BoardRow {
  late final int maxLength;
  late final List<String> _letters;
  late final List<LetterStatus>? _lettersStatus;
  int _currentLetterIndex = 0;

  int get currentLetterIndex => _currentLetterIndex;
  bool get isFilled => _letters.length == maxLength;
  List<String> get letters => List.from(_letters);

  String letterAt(final int i) => _letters[i];

  List<LetterStatus> get lettersStatus =>
      (_lettersStatus == null) ? <LetterStatus>[] : List.from(_lettersStatus!);

  bool setLettersStatus(List<LetterStatus> lettersStatus) {
    if (_lettersStatus != null) {
      return false;
    }
    _lettersStatus = List.from(lettersStatus);
    return true;
  }

  BoardRow(final int length) : assert(length > 0) {
    maxLength = length;
    _letters = List.filled(length, '');
  }

  bool inputLetter(final String letter) {
    if (_currentLetterIndex <= maxLength) {
      _letters[_currentLetterIndex] = letter;
      _currentLetterIndex += 1;
      return true;
    }
    return false;
  }

  bool removeLetter() {
    if (_currentLetterIndex > 0) {
      _currentLetterIndex -= 1;
      _letters[_currentLetterIndex] = '';
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return _letters.join('');
  }
}
