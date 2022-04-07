class BoardRow {
  late final int maxLength;
  late final List<String> _letters;
  int _currentLetterIndex = 0;

  List<String> get letters => List.from(_letters);
  int get currentLetterIndex => _currentLetterIndex;
  bool get isFilled => _letters.length == maxLength;
  String letterAt(final int i) => _letters[i];

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
