import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_flashcards/configs/constants.dart';
import 'package:provider/provider.dart';
import '../../animations/half_flip_animation.dart';
import '../../animations/slide_animation.dart';
import '../../enums/slide_direction.dart';
import '../../notifiers/flashcards_notifier.dart';
import 'card_display.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => GestureDetector(
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;
          if (velocity > 100) {
            notifier.runSwipeCard2(SlideDirection.leftAway);
          } else if (velocity < -100) {
            notifier.runSwipeCard2(SlideDirection.rightAway);
          }
          notifier.runSlideCard1();
          notifier.setIgnoreTouch(true);
          notifier.generateCurrentWord(context);
        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard2,
          reset: notifier.resetFlipCard2,
          flipFromHalfWay: true,
          animationCompleted: () => notifier.setIgnoreTouch(false),
          child: SlideAnimation(
            animationCompleted: () => notifier.resetCard2(),
            reset: notifier.resetSwipeCard2,
            animate: notifier.swipeCard2,
            direction: notifier.swipedDirection,
            child: Center(
              child: Container(
                width: size.width * 0.90,
                height: size.height * 0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kCircularBorderRadius),
                  border: Border.all(
                    color: Colors.white,
                    width: kCardBorderWidth,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: notifier.selectedWords.length > 1 ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: CardDisplay(word: notifier.selectedWords[1])) : const SizedBox(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
