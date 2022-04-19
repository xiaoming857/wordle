import 'package:flutter/material.dart';
import 'package:wordle/app/models/letter_status.dart';

class VirtualKeyboard extends StatelessWidget {
  final Map<String, LetterStatus> virtualKeys;
  final Function(String)? onPressed;

  const VirtualKeyboard(
    this.virtualKeys, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var k = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < 3; i++)
          Builder(builder: (context) {
            k += (i == 0) ? 0 : (i - 1);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var j = i; j < 10; j++)
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Builder(
                        builder: (context) {
                          final index = (i * 9) + j - k;
                          final virtualKey = virtualKeys.keys.elementAt(index);
                          var backgroundColor = Colors.transparent;
                          switch (virtualKeys[virtualKey]!) {
                            case LetterStatus.wrongPosition:
                              backgroundColor = Colors.amber;
                              break;
                            case LetterStatus.wrong:
                              backgroundColor = Colors.grey.shade400;
                              break;
                            case LetterStatus.correct:
                              backgroundColor = Colors.lime;
                              break;
                            case LetterStatus.empty:
                              break;
                          }

                          return OutlinedButton(
                            onPressed: (onPressed == null)
                                ? () {}
                                : () => onPressed!(virtualKey),
                            child: (virtualKey == 'BACKSPACE')
                                ? const Icon(
                                    Icons.backspace_outlined,
                                    size: 18,
                                  )
                                : Text(
                                    virtualKey,
                                  ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(backgroundColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              overlayColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.isNotEmpty) {
                                  switch (states.first) {
                                    case MaterialState.hovered:
                                      if (backgroundColor ==
                                          Colors.transparent) {
                                        return Colors.blue.withOpacity(0.2);
                                      }
                                      return Colors.white.withOpacity(0.2);
                                    case MaterialState.pressed:
                                      if (backgroundColor ==
                                          Colors.transparent) {
                                        return Colors.blue.withOpacity(0.2);
                                      }
                                      return Colors.white.withOpacity(0.2);
                                    default:
                                      break;
                                  }
                                }
                                return Colors.transparent;
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            );
          }),
      ],
    );
  }
}
