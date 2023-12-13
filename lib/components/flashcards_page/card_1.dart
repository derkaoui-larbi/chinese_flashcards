import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/flashcards_page/card_display.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flashcardsNotifier = Provider.of<FlashcardsNotifier>(context);
    final word = flashcardsNotifier.selectedWords.isNotEmpty ? flashcardsNotifier.selectedWords[0] : null;

    return GestureDetector(
      onDoubleTap: () => flashcardsNotifier.runFlipCard1(),
      child: word != null
          ? CardDisplay(word: word, showQuestion: true)
          : const SizedBox(),
    );
  }
}
