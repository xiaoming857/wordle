import 'package:flutter/material.dart';

class VirtualKeyboard extends StatelessWidget {
  static const keys = [
    ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
    ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
    ['Z', 'X', 'C', 'V', 'B', 'N', 'M', 'BACKSPACE']
  ];

  const VirtualKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 9; i >= 7; i--)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var j = i; j >= 0; j--)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: (keys[9 - i][i - j] == 'BACKSPACE')
                          ? const Icon(
                              Icons.backspace_outlined,
                              size: 18,
                            )
                          : Text(
                              keys[9 - i][i - j].toString(),
                            ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
