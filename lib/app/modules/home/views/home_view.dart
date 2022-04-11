import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/models/letter_status.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
      ),
      body: Center(
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: controller.onKey,
          child: Obx(() {
            final board = controller.board.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Card(
                    margin: const EdgeInsets.all(25),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Text(
                                'Key pressed:',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    controller.keyPressed.value,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                for (int i = 0; i < board.rowsLength; i++)
                  Builder(builder: (context) {
                    final row = board.rowAt(i);
                    if (i < board.currentRowIndex) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = 0; j < row.maxLength; j++)
                            Builder(builder: (context) {
                              Color? tileColor;
                              switch (row.lettersStatus[j]) {
                                case LetterStatus.wrongPosition:
                                  tileColor = Colors.amber;
                                  break;
                                case LetterStatus.wrong:
                                  tileColor = Colors.grey.shade400;
                                  break;
                                case LetterStatus.correct:
                                  tileColor = Colors.lime;
                                  break;
                                case LetterStatus.empty:
                                  tileColor = Colors.red;
                                  break;
                              }
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Material(
                                  elevation: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: tileColor,
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: Text(
                                        row.letterAt(j),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = 0; j < row.maxLength; j++)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              elevation:
                                  (i == board.currentRowIndex && !board.isDone)
                                      ? 5
                                      : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (row.letterAt(j).isEmpty)
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                                height: (i == board.currentRowIndex &&
                                        !board.isDone)
                                    ? 45
                                    : 40,
                                width: (i == board.currentRowIndex &&
                                        !board.isDone)
                                    ? 45
                                    : 40,
                                child: Center(
                                  child: Text(
                                    row.letterAt(j),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
