import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/app/tts_button.dart';
import 'package:flutter_flashcards/notifiers/settings_notifier.dart';
import 'package:provider/provider.dart';
import '../../models/word.dart';
import '../../enums/settings.dart';

class CardDisplay extends StatelessWidget {
  final Word word;
  final bool showQuestion; // New parameter to indicate question/answer

  const CardDisplay({
    required this.word,
    required this.showQuestion, // Accept this parameter
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    // Determine what content to display based on the showQuestion flag
    final contentToShow = showQuestion ? word.question : word.pinyin;

    // Check if content is available
    if (contentToShow.isEmpty) {
      return _noFlashcardsMessage();
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[200], // Background color to distinguish the card
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              contentToShow,
              style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            if (!settingsNotifier.displayOptions[Settings.audioOnly]! ?? true)
              TTSButton(word: word, iconSize: 30), // Smaller TTS button
          ],
        ),
      ),
    );
  }

  Widget _noFlashcardsMessage() {
    return const Center(
      child: Text(
        'This topic has no flashcards.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
