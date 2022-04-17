import 'package:wordle/app/models/letter_status.dart';

/// BoardRow
///
/// ## description
/// The [BoardRow] is a row of letters in a wordle board game. It is
/// the place where users will input their guesses. Once the letter
/// status is filled, users can no longer insert or remove any letters
/// from the row.
///
/// ## parameters
/// - [maxLength] [int] defines the maximum length of the row. Users
///   need to input exactly the same length of letters.
class BoardRow {
  late final int _maxLength;
  late final List<String> _letters;
  late List<LetterStatus> _lettersStatus;
  int _currentLetterIndex = 0;
  bool _isFinalized = false;

  BoardRow(final int maxLength) : assert(maxLength > 0) {
    _maxLength = maxLength;
    _letters = List.filled(maxLength, '');
    _lettersStatus = List.filled(maxLength, LetterStatus.empty);
  }

  bool get isFilled => _currentLetterIndex >= _maxLength;
  bool get isFinalized => _isFinalized;
  List<String> get letters => List.from(_letters);
  List<LetterStatus> get lettersStatus => List.from(_lettersStatus);

  bool setLettersStatus(List<LetterStatus> lettersStatus) {
    if (isFinalized ||
        lettersStatus.length != _maxLength ||
        lettersStatus.contains(LetterStatus.empty)) {
      return false;
    }
    _lettersStatus = List.from(lettersStatus);
    _isFinalized = true;
    return true;
  }

  String letterAt(final int i) =>
      !(i >= 0 && i < _maxLength) ? '' : _letters[i];

  bool inputLetter(final String letter) {
    if (!_isFinalized && _currentLetterIndex < _maxLength) {
      _letters[_currentLetterIndex] = letter;
      _currentLetterIndex += 1;
      return true;
    }
    return false;
  }

  bool removeLetter() {
    if (!_isFinalized && _currentLetterIndex > 0) {
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
