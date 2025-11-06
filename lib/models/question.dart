class Question {
  final String id;
  final String category;
  final Map<String, String> texts;
  final String answerType;
  final List<String>? options;
  final int? minRating;
  final int? maxRating;
  final bool premium;

  Question({
    required this.id,
    required this.category,
    required this.texts,
    required this.answerType,
    this.options,
    this.minRating,
    this.maxRating,
    this.premium = false,
  });

  String getText(String languageCode) {
    return texts['text_$languageCode'] ?? texts['text_tr'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        ...texts,
        'answer_type': answerType,
        if (options != null) 'options': options,
        if (minRating != null) 'min': minRating,
        if (maxRating != null) 'max': maxRating,
        'premium': premium,
      };

  factory Question.fromJson(Map<String, dynamic> json) {
    final Map<String, String> texts = {};
    json.forEach((key, value) {
      if (key.startsWith('text_') && value is String) {
        texts[key] = value;
      }
    });

    return Question(
      id: json['id'] as String,
      category: json['category'] as String,
      texts: texts,
      answerType: json['answer_type'] as String,
      options: json['options'] != null
          ? List<String>.from(json['options'] as List)
          : null,
      minRating: json['min'] as int?,
      maxRating: json['max'] as int?,
      premium: json['premium'] as bool? ?? false,
    );
  }

  bool get isBinary => answerType == 'binary';
  bool get isRating => answerType == 'rating';
}