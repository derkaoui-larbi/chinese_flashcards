import 'package:flutter/material.dart';
import 'package:flutter_flashcards/animations/fade_in_animation.dart';
import 'package:flutter_flashcards/configs/constants.dart';
import 'package:flutter_flashcards/databases/database_manager.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:flutter_flashcards/notifiers/review_notifier.dart';
import 'package:flutter_flashcards/pages/flashcards_page.dart';
import 'package:flutter_flashcards/pages/review_page.dart';
import 'package:flutter_flashcards/pages/settings_page.dart';
import 'package:flutter_flashcards/pages/add_topic_page.dart';
import 'package:provider/provider.dart';

import '../components/home_page/topic_tile.dart';

class HomePage extends StatefulWidget {
  static const String id = '/HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widthPadding = size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
            )
        ),
        toolbarHeight: size.height * 0.15,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIcon(
                imagePath: 'assets/images/Settings.png',
                onTap: () => _navigateToSettingsPage(context),
                size: size
            ),
            const FadeInAnimation(
                child: Text(
                  'MyFlashcardsApp',
                  textAlign: TextAlign.center,
                )
            ),
            _buildIcon(
                imagePath: 'assets/images/Review.png',
                onTap: () => _loadReviewPage(context),
                size: size
            ),
          ],
        ),
      ),
      body: Consumer<FlashcardsNotifier>(
        builder: (context, notifier, _) {
          var topics = notifier.getAllTopics(); // Retrieves all topics, both hardcoded and dynamically added

          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: widthPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: topics.length + 1, // Plus one for the add button
            itemBuilder: (context, index) {
              if (index < topics.length) {
                return TopicTile(topic: topics[index]);
              } else {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTopicPage()),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(Icons.add, size: 64, color: Colors.black54),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FlashcardsPage(topic: '',)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _loadReviewPage(BuildContext context) {
    Provider.of<FlashcardsNotifier>(context, listen: false).setTopic('Review');
    DatabaseManager().selectWords().then((words) {
      final reviewNotifier = Provider.of<ReviewNotifier>(context, listen: false);
      reviewNotifier.disableButtons(disable: words.isEmpty);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewPage()));
    });
  }

  void _navigateToSettingsPage(BuildContext context) {
    Provider.of<FlashcardsNotifier>(context, listen: false).setTopic('Settings');
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
  }

  Widget _buildIcon({required String imagePath, required VoidCallback onTap, required Size size}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.width * kIconPadding,
        child: Image.asset(imagePath),
      ),
    );
  }
}
