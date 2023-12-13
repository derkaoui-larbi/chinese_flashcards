import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/flashcards_page/card_display.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flashcardsNotifier = Provider.of<FlashcardsNotifier>(context);
    final word = flashcardsNotifier.selectedWords.length > 1 ? flashcardsNotifier.selectedWords[1] : null;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        // Handle swipe logic
        if (details.primaryVelocity != null) {
          if (details.primaryVelocity! < 0) {
            // Swipe left - mark as incorrect
            flashcardsNotifier.updateCardOutcome(word!, false);
          } else if (details.primaryVelocity! > 0) {
            // Swipe right - mark as correct
            flashcardsNotifier.updateCardOutcome(word!, true);
          }
        }
        // Proceed to the next word
        flashcardsNotifier.generateCurrentWord(context);
      },
      child: word != null
          ? Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi), // For flip effect
        child: CardDisplay(word: word, showQuestion: false),
      )
          : const SizedBox(),
    );
  }
}
