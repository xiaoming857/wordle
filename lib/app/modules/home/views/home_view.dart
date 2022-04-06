import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/services/generator.dart';

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
            String wordOfTheDay = controller.board.value.wordle;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Key pressed: ${controller.keyPressed.value}'),
                for (int i = 0; i < controller.board.value.rows.length; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < wordOfTheDay.length; j++)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                            elevation: (j ==
                                    controller.board.value.rows[i].currentIndex)
                                ? 5
                                : 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (controller.board.value.rows[i]
                                          .characters[j].isEmpty)
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              height: (j ==
                                      controller
                                          .board.value.rows[i].currentIndex)
                                  ? 45
                                  : 40,
                              width: (j ==
                                      controller
                                          .board.value.rows[i].currentIndex)
                                  ? 45
                                  : 40,
                              child: Center(
                                child: Text(controller
                                    .board.value.rows[i].characters[j]),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Generator().generateWordOfTheDay,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
