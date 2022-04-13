import 'package:flutter/material.dart';
import 'package:wordle/app/models/letter_status.dart';

class GameBoardRow extends StatelessWidget {
  final List<String> letters;
  final List<LetterStatus>? lettersStatus;
  final bool isActive;

  const GameBoardRow(
    this.letters,
    this.lettersStatus, {
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int j = 0; j < letters.length; j++)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _generateTile(
                letters[j],
                (lettersStatus == null ||
                        lettersStatus!.length < letters.length)
                    ? LetterStatus.empty
                    : lettersStatus![j]),
          ),
      ],
    );
  }

  Widget _generateTile(String letter, LetterStatus letterStatus) {
    final content = Center(
      child: Text(
        letter,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (!isActive) {
      return Builder(builder: (context) {
        final tileColor = _generateColor(letterStatus);
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: (tileColor == Colors.transparent)
                    ? Colors.grey
                    : tileColor),
            color: tileColor,
          ),
          height: 40,
          width: 40,
          child: content,
        );
      });
    }
    return Material(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: (letter.isEmpty) ? Colors.grey : Colors.black,
          ),
        ),
        height: 45,
        width: 45,
        child: content,
      ),
    );
  }

  Color _generateColor(LetterStatus letterStatus) {
    if (isActive) {
      return Colors.transparent;
    }
    switch (letterStatus) {
      case LetterStatus.wrongPosition:
        return Colors.amber;
      case LetterStatus.wrong:
        return Colors.grey.shade400;
      case LetterStatus.correct:
        return Colors.lime;
      case LetterStatus.empty:
        return Colors.transparent;
    }
  }
}
