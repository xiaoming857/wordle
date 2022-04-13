import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/models/game_status.dart';
import 'package:wordle/app/widgets/game_board_row.dart';

import '../controllers/game_board_controller.dart';

class GameBoardView extends GetView<GameBoardController> {
  const GameBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameBoardView'),
      ),
      body: Center(
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: FocusNode(),
          onKey: controller.onKey,
          child: Obx(() {
            final game = controller.game.value;
            final board = game.board;
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
                for (int i = 0; i < board.maxTries; i++)
                  GameBoardRow(
                    board.rowAt(i).letters,
                    board.rowAt(i).lettersStatus,
                    isActive: (i == board.currentRowIndex &&
                        game.currentGameStatus == GameStatus.onGoing),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
