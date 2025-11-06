import 'package:uuid/uuid.dart';

class Player {
  final String id;
  String name;
  int order;
  int totalOK;
  int totalNOK;
  double averageRating;
  int totalQuestions;
  Map<String, int> categoryStats;

  Player({
    String? id,
    required this.name,
    required this.order,
    this.totalOK = 0,
    this.totalNOK = 0,
    this.averageRating = 0.0,
    this.totalQuestions = 0,
    Map<String, int>? categoryStats,
  })  : id = id ?? const Uuid().v4(),
        categoryStats = categoryStats ?? {};

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'order': order,
        'totalOK': totalOK,
        'totalNOK': totalNOK,
        'averageRating': averageRating,
        'totalQuestions': totalQuestions,
        'categoryStats': categoryStats,
      };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'] as String,
        name: json['name'] as String,
        order: json['order'] as int,
        totalOK: json['totalOK'] as int? ?? 0,
        totalNOK: json['totalNOK'] as int? ?? 0,
        averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
        totalQuestions: json['totalQuestions'] as int? ?? 0,
        categoryStats: Map<String, int>.from(
          json['categoryStats'] as Map? ?? {},
        ),
      );

  Player updateStats({
    String? answer,
    double? rating,
    required String category,
  }) {
    int newTotalOK = totalOK;
    int newTotalNOK = totalNOK;
    double newAvgRating = averageRating;
    int newTotalQuestions = totalQuestions + 1;

    if (answer != null) {
      if (answer.toLowerCase().contains('ok') ||
          answer.toLowerCase().contains('yapabilir') ||
          answer.toLowerCase().contains('kıskanmam') ||
          answer.toLowerCase().contains('değil')) {
        newTotalOK++;
      } else {
        newTotalNOK++;
      }
    }

    if (rating != null) {
      newAvgRating = ((averageRating * totalQuestions) + rating) / newTotalQuestions;
    }

    final newCategoryStats = Map<String, int>.from(categoryStats);
    newCategoryStats[category] = (newCategoryStats[category] ?? 0) + 1;

    return Player(
      id: id,
      name: name,
      order: order,
      totalOK: newTotalOK,
      totalNOK: newTotalNOK,
      averageRating: newAvgRating,
      totalQuestions: newTotalQuestions,
      categoryStats: newCategoryStats,
    );
  }

  Player copyWith({
    String? id,
    String? name,
    int? order,
    int? totalOK,
    int? totalNOK,
    double? averageRating,
    int? totalQuestions,
    Map<String, int>? categoryStats,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
      totalOK: totalOK ?? this.totalOK,
      totalNOK: totalNOK ?? this.totalNOK,
      averageRating: averageRating ?? this.averageRating,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      categoryStats: categoryStats ?? this.categoryStats,
    );
  }
}