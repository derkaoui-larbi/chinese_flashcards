import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/app/tts_button.dart';
import 'package:flutter_flashcards/notifiers/settings_notifier.dart';
import 'package:provider/provider.dart';
import '../../models/word.dart';
import '../../enums/settings.dart';

class CardDisplay extends StatelessWidget {
  final Word word;

  const CardDisplay({
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Consumer<SettingsNotifier>(
        builder: (_, settingsNotifier, __) {
          final setEnglishFirst = settingsNotifier.displayOptions[Settings.englishFirst] ?? false;
          final showPinyin = settingsNotifier.displayOptions[Settings.showPinyin] ?? false;
          final audioOnly = settingsNotifier.displayOptions[Settings.audioOnly] ?? false;

          // Check if the word has content to display
          if (word.question.isEmpty || word.pinyin.isEmpty) {
            return _noFlashcardsMessage();
          }

          return buildCardContents(word, setEnglishFirst, showPinyin, audioOnly, context);
        },
      ),
    );
  }

  Column buildCardContents(
      Word word,
      bool setEnglishFirst,
      bool showPinyin,
      bool audioOnly,
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (audioOnly) ...[
          TTSButton(word: word),
        ] else ...[
          if (!setEnglishFirst || showPinyin) buildTextBox(word.question, context, 3),
          if (showPinyin) buildTextBox(word.pinyin, context, 1),
          TTSButton(word: word),
        ],
      ],
    );
  }

  Expanded buildTextBox(String text, BuildContext context, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }

  Widget _noFlashcardsMessage() {
    return Center(
      child: Text(
        'This topic has no flashcards.',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
