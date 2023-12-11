import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/flashcards_page/results_box.dart';
import 'package:flutter_flashcards/configs/constants.dart';
import 'package:flutter_flashcards/data/words.dart';
import 'package:flutter_flashcards/enums/slide_direction.dart';
import 'package:flutter_flashcards/models/word.dart';

class FlashcardsNotifier extends ChangeNotifier {
  int roundTally = 0,
      cardTally = 0,
      correctTally = 0,
      incorrectTally = 0,
      correctPercentage = 0;

  double percentComplete = 0.0;
  Map<String, List<Word>> topicsFlashcards = {}; // Map to store topics and their flashcards
  Map<String, String> topicImages = {};
  String currentTopic = "";
  Word word1 = Word(topic: "", chapter: "Loading", question: "", pinyin: "");
  Word word2 = Word(topic: "", chapter: "Loading", question: "", pinyin: "");
  List<Word> selectedWords = [];
  List<Word> incorrectCards = [];

  bool isFirstRound = true,
      isRoundCompleted = false,
      isSessionCompleted = false,
      ignoreTouches = true;

  SlideDirection swipedDirection = SlideDirection.none;
  bool slideCard1 = false,
      flipCard1 = false,
      flipCard2 = false,
      swipeCard2 = false;
  bool resetSlideCard1 = false,
      resetFlipCard1 = false,
      resetFlipCard2 = false,
      resetSwipeCard2 = false;

  // Existing methods...

  void calculateCorrectPercentage() {
    if (cardTally != 0) {
      final percentage = correctTally / cardTally;
      correctPercentage = (percentage * 100).round();
    }
    notifyListeners();
  }

  void calculateCompletedPercent() {
    if (cardTally != 0) {
      percentComplete = (correctTally + incorrectTally) / cardTally;
    }
    notifyListeners();
  }

  void resetProgressBar() {
    percentComplete = 0.0;
    notifyListeners();
  }

  void reset() {
    incorrectCards.clear();
    isFirstRound = true;
    isRoundCompleted = false;
    isSessionCompleted = false;
    roundTally = 0;
    percentComplete = 0.0;
    correctTally = 0;
    incorrectTally = 0;
    notifyListeners();
  }

  void setTopic(String newTopic) {
    currentTopic = newTopic;
    selectedWords = topicsFlashcards[newTopic] ?? [];
    notifyListeners();
  }

  void addTopicWithFlashcards(String topicName, List<Map<String, String>> flashcardsData, String imageUrl) {
    List<Word> flashcards = flashcardsData.map((data) => Word(
      topic: topicName,
      chapter: '',
      question: data['front'] ?? '',
      pinyin: data['back'] ?? '',
    )).toList();

    topicsFlashcards[topicName] = flashcards;
    topicImages[topicName] = imageUrl.isNotEmpty ? imageUrl : getRandomImageUrl();
    notifyListeners();
  }

  String getRandomImageUrl() {
    List<String> defaultImages = ['default1.png', 'default2.png', 'default3.png'];
    return 'assets/images/' + (defaultImages..shuffle()).first;
  }

  void addFlashcard(String topicName, String frontText, String backText) {
    final newFlashcard = Word(
      topic: topicName,
      chapter: '',
      question: frontText,
      pinyin: backText,
    );

    if (topicsFlashcards.containsKey(topicName)) {
      topicsFlashcards[topicName]?.add(newFlashcard);
    } else {
      topicsFlashcards[topicName] = [newFlashcard];
    }
    notifyListeners();
  }

  void refreshFlashcards() {
    notifyListeners();
  }

  List<String> getAllTopics() {
    List<String> allTopics = ['CSC2303', 'CSC3324', 'CSC1401']; // Hardcoded topics
    allTopics.addAll(topicsFlashcards.keys); // Add dynamically added topics
    return allTopics;
  }

  void generateAllSelectedWords() {
    words.shuffle();
    selectedWords.clear();
    isRoundCompleted = false;
    isFirstRound = true;
    if (currentTopic == 'Random 5') {
      selectedWords.addAll(words.take(5));
    } else if (currentTopic == 'Random 20') {
      selectedWords.addAll(words.take(20));
    } else if (currentTopic == 'Test All') {
      selectedWords.addAll(words);
    } else if (currentTopic != 'Review') {
      selectedWords.addAll(words.where((element) => element.topic == currentTopic));
    }
    roundTally++;
    cardTally = selectedWords.length;
    correctTally = 0;
    incorrectTally = 0;
    resetProgressBar();
  }

  void generateCurrentWord(BuildContext context) {
    if (selectedWords.isNotEmpty) {
      final r = Random().nextInt(selectedWords.length);
      word1 = selectedWords[r];
      selectedWords.removeAt(r);
    } else {
      if (incorrectCards.isEmpty) {
        isSessionCompleted = true;
      }
      isRoundCompleted = true;
      isFirstRound = false;
      calculateCorrectPercentage();
      Future.delayed(const Duration(milliseconds: 500), () {
        showDialog(context: context, builder: (context) => const ResultsBox());
      });
    }

    Future.delayed(const Duration(milliseconds: kSlideAwayDuration), () {
      word2 = word1;
    });
  }

  void updateCardOutcome(Word word, bool isCorrect) {
    if (!isCorrect) {
      incorrectCards.add(word);
      incorrectTally++;
    } else {
      correctTally++;
    }
    calculateCompletedPercent();
  }

  // Animation Code
  void setIgnoreTouch(bool ignore) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  void runSlideCard1() {
    resetSlideCard1 = false;
    slideCard1 = true;
    notifyListeners();
  }

  void runFlipCard1() {
    resetFlipCard1 = false;
    flipCard1 = true;
    notifyListeners();
  }

  void resetCard1() {
    resetSlideCard1 = true;
    resetFlipCard1 = true;
    slideCard1 = false;
    flipCard1 = false;
  }

  void runFlipCard2() {
    resetFlipCard2 = false;
    flipCard2 = true;
    notifyListeners();
  }

  void runSwipeCard2(SlideDirection direction) {
    updateCardOutcome(word2, direction == SlideDirection.leftAway);
    swipedDirection = direction;
    resetSwipeCard2 = false;
    swipeCard2 = true;
    notifyListeners();
  }

  void resetCard2() {
    resetFlipCard2 = true;
    resetSwipeCard2 = true;
    flipCard2 = false;
    swipeCard2 = false;
  }
}
