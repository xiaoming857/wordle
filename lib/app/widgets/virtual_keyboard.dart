import 'package:flutter/material.dart';
import 'package:wordle/app/models/letter_status.dart';
import 'package:wordle/app/widgets/virtual_keyboard_controller.dart';

class VirtualKeyboard extends StatefulWidget {
  final size = 50.0;
  final spacing = 6.0;
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
  _VirtualKeyboardState createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  build(BuildContext context) {
    final size = widget.size;
    final spacing = widget.spacing;
    final controller = widget.controller;
    final onLetterKeyPressed = widget.onLetterKeyPressed;
    final onBackspacePressed = widget.onBackspacePressed;
    final onEnterPressed = widget.onEnterPressed;
    final onKeyPressed = widget.onKeyPressed;

    var k = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < 4; i++)
          Theme(
            data: Theme.of(context).copyWith(
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    if (states.isNotEmpty) {
                      switch (states.first) {
                        case MaterialState.pressed:
                          return Colors.blue.withOpacity(0.3);
                        default:
                          break;
                      }
                    }
                    return Colors.transparent;
                  }),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  side: MaterialStateProperty.resolveWith((states) {
                    late var color = Colors.grey.shade300;
                    if (states.isNotEmpty) {
                      final state = states.first;
                      if (state == MaterialState.hovered ||
                          state == MaterialState.pressed) {
                        color = Colors.black;
                      }
                    }
                    return BorderSide(color: color, width: 1);
                  }),
                ),
              ),
            ),
            child: Builder(builder: (context) {
              if (i < 3) {
                k += (i == 0) ? 0 : (i - 1);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var j = i; j < 10; j++)
                      Padding(
                        padding: EdgeInsets.all(spacing),
                        child: SizedBox(
                          height: size,
                          width: size,
                          child: Builder(
                            builder: (context) {
                              final index = (i * 9) + j - k;
                              if (index < 26) {
                                final virtualKey = controller.keyAt(index);
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

                                return AnimatedContainer(
                                  color: backgroundColor,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInToLinear,
                                  child: OutlinedButton(
                                    onPressed: (onLetterKeyPressed == null)
                                        ? null
                                        : () {
                                            onLetterKeyPressed(virtualKey);
                                            onKeyPressed?.call();
                                          },
                                    child: Text(
                                      virtualKey,
                                    ),
                                  ),
                                );
                              }
                              return OutlinedButton(
                                onPressed: (onBackspacePressed == null)
                                    ? null
                                    : () {
                                        onBackspacePressed();
                                        onKeyPressed?.call();
                                      },
                                child: const Icon(
                                  Icons.backspace_outlined,
                                  size: 18,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(spacing),
                  child: SizedBox(
                    height: size,
                    width: (size * 7) + (spacing * 6 * 2),
                    child: OutlinedButton(
                      child: const Text('Enter'),
                      onPressed: (onEnterPressed == null)
                          ? null
                          : () {
                              onEnterPressed();
                              onKeyPressed?.call();
                            },
                    ),
                  ),
                );
              }
            }),
          ),
      ],
    );
  }
}
