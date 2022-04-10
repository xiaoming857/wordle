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
        title: const Text('HomeView'),
        centerTitle: true,
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
                Text('Key pressed: ${controller.keyPressed.value}'),
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
                                        style: TextStyle(
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
                              elevation: (i == board.currentRowIndex) ? 5 : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (row.letterAt(j).isEmpty)
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                                height: (i == board.currentRowIndex) ? 45 : 40,
                                width: (i == board.currentRowIndex) ? 45 : 40,
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
