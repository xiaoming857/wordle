import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/models/board.dart';
import 'package:wordle/app/models/board_row.dart';

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
            Board board = controller.board.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Key pressed: ${controller.keyPressed.value}'),
                for (int i = 0; i < board.rowsLength; i++)
                  Builder(builder: (context) {
                    BoardRow row = board.rowAt(i);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = 0; j < row.maxLength; j++)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              elevation: (j == row.currentLetterIndex) ? 5 : 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (row.letterAt(j).isEmpty)
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                                height: (j == row.currentLetterIndex) ? 45 : 40,
                                width: (j == row.currentLetterIndex) ? 45 : 40,
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
