import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/flashcards_page/progress_bar.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter_flashcards/pages/add_flashcard_page.dart';
import 'package:flutter_flashcards/utils/methods.dart';
import 'package:provider/provider.dart';

import '../components/app/custom_appbar.dart';
import '../components/flashcards_page/card_display.dart';
import '../configs/constants.dart';

class FlashcardsPage extends StatefulWidget {
  final String topic;

  const FlashcardsPage({Key? key, required this.topic}) : super(key: key);

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final flashcardsNotifier = Provider.of<FlashcardsNotifier>(context, listen: false);
      flashcardsNotifier.setTopic(widget.topic);
      flashcardsNotifier.generateAllSelectedWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kAppBarHeight),
          child: CustomAppBar(topic: widget.topic),
        ),
        body: Stack(
          children: [
            const Align(alignment: Alignment.bottomCenter, child: ProgressBar()),
            if (notifier.selectedWords.isNotEmpty) ...[
              for (int i = 0; i < notifier.selectedWords.length; i++)
                CardDisplay(word: notifier.selectedWords[i]),
            ],
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddFlashcardPage()),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
