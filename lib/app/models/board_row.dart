class BoardRow {
  late final int maxLength;
  late final List<String> _characters;
  int currentIndex = 0;

  List<String> get characters {
    return _characters;
  }

  BoardRow(String wordle) : assert(wordle.isNotEmpty) {
    maxLength = wordle.length;
    _characters = List.filled(maxLength, '');
  }

  bool inputChar(String character) {
    if (currentIndex <= maxLength) {
      _characters[currentIndex] = character;
      currentIndex += 1;
      return true;
    }
    return false;
  }

  bool removeChar() {
    if (currentIndex > 0) {
      currentIndex -= 1;
      _characters[currentIndex] = '';
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return _characters.join('');
  }
}
