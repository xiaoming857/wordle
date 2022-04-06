class BoardRow {
  late final int maxLength;
  late final List<String> _characters;
  int currentCharIndex = 0;

  String charAt(int i) => _characters[i];

  BoardRow(String wordle) : assert(wordle.isNotEmpty) {
    maxLength = wordle.length;
    _characters = List.filled(maxLength, '');
  }

  bool inputChar(String character) {
    if (currentCharIndex <= maxLength) {
      _characters[currentCharIndex] = character;
      currentCharIndex += 1;
      return true;
    }
    return false;
  }

  bool removeChar() {
    if (currentCharIndex > 0) {
      currentCharIndex -= 1;
      _characters[currentCharIndex] = '';
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return _characters.join('');
  }
}
