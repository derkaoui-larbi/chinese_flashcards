class Word {
  int? id;
  final String topic;
  final String chapter;
  final String question;
  final String pinyin;

  // Constructor for creating a Word with data.
  Word({
    this.id,
    required this.topic,
    required this.chapter,
    required this.question,
    required this.pinyin,
  });

  // Named constructor for creating an empty Word object.
  Word.empty()
      : id = null,
        topic = '',
        chapter = '',
        question = '',
        pinyin = '';

  // Convert a Word object into a Map. Useful for database operations.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'topic': topic,
      'chapter': chapter,
      'question': question,
      'pinyin': pinyin,
    };
  }

  // Create a Word object from a Map. Useful when retrieving data from a database.
  factory Word.fromMap({required Map<String, dynamic> map}) {
    return Word(
      id: map['id'],
      topic: map['topic'],
      chapter: map['chapter'],
      question: map['question'],
      pinyin: map['pinyin'],
    );
  }

// Additional methods or properties, if needed, can be added here.
}
