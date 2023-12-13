import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/app/custom_appbar.dart';
import 'package:flutter_flashcards/components/flashcards_page/card_1.dart';
import 'package:flutter_flashcards/components/flashcards_page/card_2.dart';
import 'package:flutter_flashcards/components/flashcards_page/progress_bar.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter_flashcards/pages/add_flashcard_page.dart';
import 'package:flutter_flashcards/utils/methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/flashcards_page/card_1.dart';
import '../components/flashcards_page/card_2.dart';
import '../configs/constants.dart';

class FlashcardsPage extends StatefulWidget {
  final String topic;
  const FlashcardsPage({super.key, required this.topic});

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

      // Show guide box if it's the user's first time
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.getBool('guidebox') == null) {
          runGuideBox(context: context, isFirst: true);
        }
      });
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
            notifier.selectedWords.isNotEmpty
                ? const Stack(
              children: [
                Card2(),
                Card1(),
              ],
            )
                : Center(
              child: Text(
                'No flashcards available for this topic',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
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
