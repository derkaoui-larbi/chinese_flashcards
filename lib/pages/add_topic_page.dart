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
  String _imageUrl = '';
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
                  onSaved: (value) => _imageUrl = value ?? '',
                ),
                ..._flashcards.map((flashcard) {
                  return Card(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Front Text'),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter front text' : null,
                          onSaved: (value) => flashcard['front'] = value ?? '',
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Back Text'),
                          validator: (value) => value == null || value.isEmpty ? 'Please enter back text' : null,
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
