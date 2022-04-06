class BoardRow {
  late final List<String> _characters;
  late final int maxLength;

  BoardRow(String wordle) : assert(wordle.isNotEmpty) {
    _characters = List.empty(growable: true);
    maxLength = wordle.length;
  }

  bool inputChar(String character) {
    if (_characters.length < maxLength) {
      _characters.add(character);
      return true;
    }
    return false;
  }

  bool removeChar() {
    if (_characters.isNotEmpty) {
      _characters.removeLast();
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return _characters.join('');
  }
}
