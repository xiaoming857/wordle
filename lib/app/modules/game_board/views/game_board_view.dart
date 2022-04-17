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
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: Border.all(width: 0, color: Colors.transparent),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Wordle',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      FittedBox(
                        child: IconButton(
                          onPressed: controller.onOpenMenu,
                          icon: const Icon(
                            Icons.menu_rounded,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Elapsed Time'),
                              const SizedBox(height: 5.0),
                              Obx(() {
                                return Text(
                                  controller.gameTime.join(':'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          indent: 5,
                          endIndent: 5,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Key pressed',
                              ),
                              const SizedBox(height: 5.0),
                              Obx(() {
                                return Text(
                                  (controller.keyPressed.isEmpty)
                                      ? ''
                                      : controller.keyPressed.value,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RawKeyboardListener(
                  autofocus: true,
                  focusNode: FocusNode(),
                  onKey: controller.onKey,
                  child: Obx(() {
                    final game = controller.game.value;
                    final board = game.board;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}