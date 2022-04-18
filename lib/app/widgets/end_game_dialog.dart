import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordle/app/models/statistic.dart';

class EndGameDialog extends StatelessWidget {
  final Statistic statistic;
  final List<Widget> contents;

  const EndGameDialog(
    this.statistic, {
    Key? key,
    this.contents = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 36.0,
              ),
              child: Column(
                children: [
                  Text(
                    (statistic.isSuccess)
                        ? 'Congratulation!'
                        : 'Try again next time!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text((statistic.isSuccess)
                      ? 'You have successfully guessed the wordle of the day!'
                      : 'You failed to guess the wordle of the day!'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Statistics',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Divider(),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Status:'),
                              ),
                              Text(
                                (statistic.isSuccess) ? 'WIN' : 'LOSE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (statistic.isSuccess)
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Wordle of the day:'),
                              ),
                              Text(
                                statistic.wordOfTheDay,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Elapsed time:'),
                              ),
                              Text(
                                statistic.elapsedTime.join(':'),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Number of guesses:'),
                              ),
                              Text(
                                statistic.numOfGuesses.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      child: const Text('Close'),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
