import 'package:uuid/uuid.dart';
import 'player.dart';
import 'question.dart';
import 'answer.dart';

class GameSession {
  final String id;
  final String category;
  final List<Player> players;
  final List<Question> questions;
  final List<Answer> answers;
  int currentQuestionIndex;
  int currentPlayerIndex;
  final DateTime startTime;
  DateTime? endTime;
  final bool isPremium;
  bool isCompleted;

  GameSession({
    String? id,
    required this.category,
    required this.players,
    required this.questions,
    List<Answer>? answers,
    this.currentQuestionIndex = 0,
    this.currentPlayerIndex = 0,
    DateTime? startTime,
    this.endTime,
    this.isPremium = false,
    this.isCompleted = false,
  })  : id = id ?? const Uuid().v4(),
        startTime = startTime ?? DateTime.now(),
        answers = answers ?? [];

  Question? get currentQuestion {
    if (currentQuestionIndex < questions.length) {
      return questions[currentQuestionIndex];
    }
    return null;
  }

  Player get currentPlayer => players[currentPlayerIndex];

  bool get allPlayersAnswered {
    return currentPlayerIndex >= players.length - 1;
  }

  bool get isFinished {
    return currentQuestionIndex >= questions.length;
  }

  double get progress {
    final totalAnswers = players.length * questions.length;
    if (totalAnswers == 0) return 0.0;
    return answers.length / totalAnswers;
  }

  GameSession addAnswer(Answer answer) {
    final newAnswers = List<Answer>.from(answers)..add(answer);
    
    int newPlayerIndex = currentPlayerIndex;
    int newQuestionIndex = currentQuestionIndex;

    if (currentPlayerIndex < players.length - 1) {
      newPlayerIndex++;
    } else {
      newPlayerIndex = 0;
      newQuestionIndex++;
    }

    bool newIsCompleted = isCompleted;
    DateTime? newEndTime = endTime;
    if (newQuestionIndex >= questions.length) {
      newIsCompleted = true;
      newEndTime = DateTime.now();
    }

    return GameSession(
      id: id,
      category: category,
      players: players,
      questions: questions,
      answers: newAnswers,
      currentQuestionIndex: newQuestionIndex,
      currentPlayerIndex: newPlayerIndex,
      startTime: startTime,
      endTime: newEndTime,
      isPremium: isPremium,
      isCompleted: newIsCompleted,
    );
  }

  List<Answer> getAnswersForQuestion(String questionId) {
    return answers.where((a) => a.questionId == questionId).toList();
  }

  List<Answer> getAnswersByPlayer(String playerId) {
    return answers.where((a) => a.playerId == playerId).toList();
  }

  Map<String, dynamic> getPlayerStats(String playerId) {
    final playerAnswers = getAnswersByPlayer(playerId);
    int okCount = 0;
    int nokCount = 0;
    double totalRating = 0;
    int ratingCount = 0;

    for (var answer in playerAnswers) {
      if (answer.binaryAnswer != null) {
        if (answer.isPositive) {
          okCount++;
        } else {
          nokCount++;
        }
      }
      if (answer.ratingAnswer != null) {
        totalRating += answer.ratingAnswer!;
        ratingCount++;
      }
    }

    return {
      'okCount': okCount,
      'nokCount': nokCount,
      'averageRating': ratingCount > 0 ? totalRating / ratingCount : 0.0,
      'totalAnswers': playerAnswers.length,
    };
  }

  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  GameSession copyWith({
    String? id,
    String? category,
    List<Player>? players,
    List<Question>? questions,
    List<Answer>? answers,
    int? currentQuestionIndex,
    int? currentPlayerIndex,
    DateTime? startTime,
    DateTime? endTime,
    bool? isPremium,
    bool? isCompleted,
  }) {
    return GameSession(
      id: id ?? this.id,
      category: category ?? this.category,
      players: players ?? this.players,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isPremium: isPremium ?? this.isPremium,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}