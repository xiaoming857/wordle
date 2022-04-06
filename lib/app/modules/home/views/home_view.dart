import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/services/generator.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    String wordOfTheDay = controller.wordOfTheDay;
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Key pressed: ${controller.keyPressed.value}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < wordOfTheDay.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Material(
                          elevation: (i == controller.currentIndex) ? 5 : 0,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: (controller.word.value[i].isEmpty)
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            height: (i == controller.currentIndex) ? 45 : 40,
                            width: (i == controller.currentIndex) ? 45 : 40,
                            child: Center(
                              child: Text(controller.word.value[i]),
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
