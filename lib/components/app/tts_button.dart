import 'package:flutter/material.dart';
import 'package:flutter_flashcards/configs/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../models/word.dart';

class TTSButton extends StatefulWidget {
  final Word word;
  final double iconSize;

  const TTSButton({Key? key, required this.word, this.iconSize = 50}) : super(key: key);

  @override
  State<TTSButton> createState() => _TTSButtonState();
}

class _TTSButtonState extends State<TTSButton> {
  final FlutterTts _tts = FlutterTts();
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _setUpTts();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _setUpTts() async {
    await _tts.setLanguage('zh-CN');
    await _tts.setSpeechRate(0.40);
  }

  Future<void> _runTts(String text) async {
    if (text.isNotEmpty) {
      await _tts.speak(text);
    }
  }

  void _onTap() {
    setState(() {
      _isTapped = true;
    });
    _runTts(widget.word.question).then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isTapped = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onTap,
      icon: Icon(
        Icons.audiotrack,
        size: widget.iconSize,
        color: _isTapped ? kYellow : Colors.white,
      ),
    );
  }
}
