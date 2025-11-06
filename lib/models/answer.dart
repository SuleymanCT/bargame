class Answer {
  final String playerId;
  final String playerName;
  final String questionId;
  final String? binaryAnswer;
  final double? ratingAnswer;
  final DateTime timestamp;
  final String category;

  Answer({
    required this.playerId,
    required this.playerName,
    required this.questionId,
    this.binaryAnswer,
    this.ratingAnswer,
    required this.category,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'playerName': playerName,
        'questionId': questionId,
        'binaryAnswer': binaryAnswer,
        'ratingAnswer': ratingAnswer,
        'timestamp': timestamp.toIso8601String(),
        'category': category,
      };

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        playerId: json['playerId'] as String,
        playerName: json['playerName'] as String,
        questionId: json['questionId'] as String,
        binaryAnswer: json['binaryAnswer'] as String?,
        ratingAnswer: (json['ratingAnswer'] as num?)?.toDouble(),
        category: json['category'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  String get displayAnswer {
    if (binaryAnswer != null) return binaryAnswer!;
    if (ratingAnswer != null) return '${ratingAnswer!.toInt()}/10';
    return 'N/A';
  }

  bool get isPositive {
    if (binaryAnswer == null) return false;
    final positive = ['ok', 'yapabilir', 'kıskanmam', 'değil'];
    return positive.any((p) => binaryAnswer!.toLowerCase().contains(p));
  }
}