import 'package:flutter/material.dart';
import 'package:flutter_flashcards/animations/fade_in_animation.dart';

class GuideBox extends StatelessWidget {
  const GuideBox({required this.isFirst, Key? key}) : super(key: key);

  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightPadding = size.height * 0.20;
    final widthPadding = size.width * 0.10;

    return FadeInAnimation(
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(widthPadding, heightPadding, widthPadding, heightPadding),
        content: SizedBox(
          height: size.height * 0.6, // Set a specific height for the AlertDialog content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isFirst) ...[
                const Text(
                  'Double Tap\nTo Reveal Answer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset('assets/images/GuideDoubleTap.png'),
                  ),
                )
              ] else ...[
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GuideSwipe(isLeft: true),
                      GuideSwipe(isLeft: false),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: size.width * 0.50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Got It!'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuideSwipe extends StatelessWidget {
  const GuideSwipe({required this.isLeft, Key? key}) : super(key: key);

  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isLeft ? 'Swipe Left\nIf Incorrect' : 'Swipe Right\nIf Correct',
            textAlign: isLeft ? TextAlign.left : TextAlign.right,
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                  isLeft ? 'assets/images/GuideLeftSwipe.png' : 'assets/images/GuideRightSwipe.png'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
