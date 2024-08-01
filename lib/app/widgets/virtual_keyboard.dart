import 'package:flutter/material.dart';
import 'package:wordle/app/models/letter_status.dart';
import 'package:wordle/app/widgets/virtual_key_button.dart';
import 'package:wordle/app/widgets/virtual_keyboard_controller.dart';

class VirtualKeyboard extends StatelessWidget {
  final spacing = 0.0;
  final VirtualKeyboardController controller;
  final Function(String)? onLetterKeyPressed;
  final Function()? onBackspacePressed;
  final Function()? onEnterPressed;
  final Function()? onKeyPressed;

  const VirtualKeyboard(
    this.controller, {
    Key? key,
    this.onLetterKeyPressed,
    this.onBackspacePressed,
    this.onEnterPressed,
    this.onKeyPressed,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    const padding = 10.0;
    final screenWidth = MediaQuery.of(context).size.width - (padding * 2);
    final keyWidth = screenWidth / 10; // There are 10 keys from Q to P

    var k = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < 4; i++)
            Builder(builder: (context) {
              if (i < 3) {
                k += (i == 0) ? 0 : (i - 1);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var j = i; j < 10; j++)
                      Padding(
                        padding: EdgeInsets.all(spacing),
                        child: SizedBox(
                          height: keyWidth,
                          width: keyWidth,
                          child: Builder(
                            builder: (context) {
                              final index = (i * 9) + j - k;
                              if (index < 26) {
                                final virtualKey = controller.keyAt(index);
                                return VirtualKeyButton(
                                  child: Text(virtualKey),
                                  controller: controller,
                                  size: Size(keyWidth, keyWidth),
                                  curve: Curves.easeInCirc,
                                  duration: const Duration(milliseconds: 300),
                                  backgroundColor: () {
                                    var backgroundColor = Colors.transparent;
                                    switch (controller.statusAt(virtualKey)) {
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
                                    return backgroundColor;
                                  },
                                  onPressed: (onLetterKeyPressed == null)
                                      ? null
                                      : () {
                                          onLetterKeyPressed!(virtualKey);
                                          onKeyPressed?.call();
                                        },
                                );
                              }
                              return VirtualKeyButton(
                                child: const Icon(
                                  Icons.backspace_outlined,
                                  size: 18,
                                ),
                                controller: controller,
                                size: Size(keyWidth, keyWidth),
                                onPressed: (onBackspacePressed == null)
                                    ? null
                                    : () {
                                        onBackspacePressed!();
                                        onKeyPressed?.call();
                                      },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return VirtualKeyButton(
                  child: const Text('Enter'),
                  controller: controller,
                  size: Size((keyWidth * 7) + (spacing * 6 * 2), keyWidth),
                  margin: EdgeInsets.all(spacing),
                  onPressed: (onEnterPressed == null)
                      ? null
                      : () {
                          onEnterPressed!();
                          onKeyPressed?.call();
                        },
                );
              }
            }),
        ],
      ),
    );
  }
}
