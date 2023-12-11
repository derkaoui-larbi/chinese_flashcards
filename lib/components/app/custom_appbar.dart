import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/flashcards_notifier.dart';
import '../../pages/home_page.dart';

class CustomAppBar extends StatelessWidget {
  final String topic;

  const CustomAppBar({required this.topic, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              Provider.of<FlashcardsNotifier>(context, listen: false).reset();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
            },
            icon: const Icon(Icons.clear)
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(16),
        child: Hero(
          tag: topic,
          child: Image.asset('assets/images/$topic.png', errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error); // Fallback if the image is not found
          }),
        ),
      ),
      title: Text(topic),
    );
  }
}
