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
      BuildContext context
      ) {
    return Column(
      children: [
        if (audioOnly) ...[
          TTSButton(word: word),
        ] else if (!setEnglishFirst) ...[
          buildTextBox(word.question, context, 3),
          if (showPinyin) buildTextBox(word.pinyin, context, 1),
          TTSButton(word: word),
        ] else ...[
          buildImage(word.chapter),
          buildTextBox(word.chapter, context, 1),
        ],
      ],
    );
  }

  Expanded buildImage(String image) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Image.asset('assets/images/$image.png'),
      ),
    );
  }

  Expanded buildTextBox(String text, BuildContext context, int flex) {
    return Expanded(
      flex: flex,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
