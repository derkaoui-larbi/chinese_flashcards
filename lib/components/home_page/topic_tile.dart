import 'package:flutter/material.dart';
import 'package:flutter_flashcards/animations/fade_in_animation.dart';
import 'package:flutter_flashcards/configs/constants.dart';
import 'package:flutter_flashcards/utils/methods.dart';

class TopicTile extends StatelessWidget {
  final String topic;

  const TopicTile({
    Key? key,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: GestureDetector(
        onTap: () {
          loadSession(context: context, topic: topic);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(kCircularBorderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Hero(
                    tag: topic,
                    child: _loadTopicImage(topic),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  topic,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadTopicImage(String topicName) {
    final String imagePath = 'assets/images/$topicName.png';
    final String defaultImagePath = 'assets/images/default.png';

    // Attempt to load the topic image, fallback to default image if it fails
    return Image.asset(
      imagePath,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(defaultImagePath);
      },
    );
  }
}
