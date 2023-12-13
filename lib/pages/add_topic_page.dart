import 'package:flutter/material.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

class AddTopicPage extends StatefulWidget {
  const AddTopicPage({Key? key}) : super(key: key);

  @override
  _AddTopicPageState createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  final _formKey = GlobalKey<FormState>();
  String _topicName = '';
  String _imageUrl = 'assets/images/default.png'; // Default image URL
  List<Map<String, String>> _flashcards = [];

  void _addFlashcard() {
    setState(() {
      _flashcards.add({'front': '', 'back': ''});
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final flashcardsNotifier = Provider.of<FlashcardsNotifier>(context, listen: false);

      // Validate and pass the imageUrl only if it's not empty
      String imageUrl = _imageUrl.isNotEmpty ? _imageUrl : 'assets/images/default.png';
      flashcardsNotifier.addTopicWithFlashcards(_topicName, _flashcards, _imageUrl);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Topic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Topic Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a topic name' : null,
                  onSaved: (value) => _topicName = value ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  onSaved: (value) => _imageUrl = value?.trim() ?? 'assets/images/default.png',
                ),
                ..._flashcards.map((flashcard) {
                  return Card(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Question'),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter a question' : null,
                          onSaved: (value) => flashcard['front'] = value ?? '',
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Answer'),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter an answer' : null,
                          onSaved: (value) => flashcard['back'] = value ?? '',
                        ),
                      ],
                    ),
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: _addFlashcard,
                  child: const Text('Add Flashcard'),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit Topic'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
