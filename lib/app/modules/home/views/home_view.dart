import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'WORDLE',
              style: TextStyle(
                fontSize: 56,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Get.width * 0.3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () => Get.offAndToNamed(Routes.GAME_BOARD),
                      child: const Text('Start Game'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
