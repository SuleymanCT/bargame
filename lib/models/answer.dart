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
    final answer = binaryAnswer!.toLowerCase().trim();

    // Pozitif cevaplar: OK, Yapabilir, Aldatma, Kıskanırım
    final positive = ['ok', 'yapabilir', 'aldatma', 'kıskanırım'];

    // Negatif cevaplar: NOT OK, Yapamaz, Değil, Kıskanmam
    final negative = ['not ok', 'yapamaz', 'değil', 'kıskanmam'];

    // Önce negatif kontrolü yap (çünkü "ok" hem "ok" hem "not ok"ta var)
    if (negative.any((n) => answer.contains(n))) {
      return false;
    }

    // Sonra pozitif kontrolü yap
    return positive.any((p) => answer.contains(p));
  }
}