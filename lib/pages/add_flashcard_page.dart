import 'package:flutter/material.dart';
import 'package:flutter_flashcards/notifiers/flashcards_notifier.dart';
import 'package:provider/provider.dart';

class AddFlashcardPage extends StatefulWidget {
  const AddFlashcardPage({Key? key}) : super(key: key);

  @override
  _AddFlashcardPageState createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  final _formKey = GlobalKey<FormState>();
  String _frontText = '';
  String _backText = '';

  void _submitFlashcard() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final flashcardsNotifier = Provider.of<FlashcardsNotifier>(context, listen: false);

      // Ensure that a current topic is selected before adding a flashcard
      if (flashcardsNotifier.currentTopic.isNotEmpty) {
        flashcardsNotifier.addFlashcard(flashcardsNotifier.currentTopic, _frontText, _backText);
        Navigator.of(context).pop();
      } else {
        // Handle the case when no current topic is selected
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No topic selected. Please select a topic first.'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) => _frontText = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Answer'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) => _backText = value ?? '',
              ),
              ElevatedButton(
                onPressed: _submitFlashcard,
                child: const Text('Add Flashcard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
