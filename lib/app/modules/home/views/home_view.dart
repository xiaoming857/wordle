import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wordle/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'WORDLE',
                style: TextStyle(
                  fontSize: 56,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Get.width * 0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
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
      ),
    );
  }
}
