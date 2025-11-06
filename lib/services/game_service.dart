import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../models/question.dart';
import '../models/answer.dart';
import '../models/game_session.dart';
import 'question_service.dart';

class GameService extends ChangeNotifier {
  GameSession? _currentSession;
  final QuestionService _questionService = QuestionService();
  
  GameSession? get currentSession => _currentSession;
  bool get hasActiveGame => _currentSession != null && !_currentSession!.isCompleted;
  
  Future<GameSession> startNewGame({
    required List<Player> players,
    required String category,
    int questionCount = 10,
    bool isPremium = false,
  }) async {
    final questions = await _questionService.getQuestions(
      category: category,
      count: questionCount,
    );
    
    _currentSession = GameSession(
      category: category,
      players: players,
      questions: questions,
      isPremium: isPremium,
    );
    
    notifyListeners();
    return _currentSession!;
  }
  
  Future<GameSession> startMixedGame({
    required List<Player> players,
    required Map<String, int> categoryCounts,
  }) async {
    final questions = await _questionService.getMixedQuestions(
      categoryCounts: categoryCounts,
    );
    
    _currentSession = GameSession(
      category: 'mixed',
      players: players,
      questions: questions,
      isPremium: true,
    );
    
    notifyListeners();
    return _currentSession!;
  }
  
  void submitAnswer({
    String? binaryAnswer,
    double? ratingAnswer,
  }) {
    if (_currentSession == null || _currentSession!.currentQuestion == null) {
      return;
    }
    
    final currentPlayer = _currentSession!.currentPlayer;
    final currentQuestion = _currentSession!.currentQuestion!;
    
    final answer = Answer(
      playerId: currentPlayer.id,
      playerName: currentPlayer.name,
      questionId: currentQuestion.id,
      binaryAnswer: binaryAnswer,
      ratingAnswer: ratingAnswer,
      category: currentQuestion.category,
    );
    
    _currentSession = _currentSession!.addAnswer(answer);
    
    notifyListeners();
  }
  
  Question? get currentQuestion => _currentSession?.currentQuestion;
  
  Player? get currentPlayer => _currentSession?.currentPlayer;
  
  bool get isLastPlayer {
    if (_currentSession == null) return false;
    return _currentSession!.currentPlayerIndex >= _currentSession!.players.length - 1;
  }
  
  bool get isGameFinished => _currentSession?.isFinished ?? false;
  
  double get progress => _currentSession?.progress ?? 0.0;
  
  int get remainingQuestions {
    if (_currentSession == null) return 0;
    return _currentSession!.questions.length - _currentSession!.currentQuestionIndex;
  }
  
  int get currentQuestionNumber {
    if (_currentSession == null) return 0;
    return _currentSession!.currentQuestionIndex + 1;
  }
  
  int get totalQuestions => _currentSession?.questions.length ?? 0;
  
  Map<String, dynamic> getGameResults() {
    if (_currentSession == null) {
      return {};
    }
    
    final results = <String, dynamic>{};
    
    for (var player in _currentSession!.players) {
      results[player.id] = {
        'player': player,
        'stats': _currentSession!.getPlayerStats(player.id),
        'answers': _currentSession!.getAnswersByPlayer(player.id),
      };
    }
    
    results['general'] = {
      'duration': _currentSession!.duration,
      'category': _currentSession!.category,
      'totalQuestions': _currentSession!.questions.length,
      'totalPlayers': _currentSession!.players.length,
      'isPremium': _currentSession!.isPremium,
    };
    
    final okCounts = <String, int>{};
    final nokCounts = <String, int>{};
    
    for (var player in _currentSession!.players) {
      final stats = _currentSession!.getPlayerStats(player.id);
      okCounts[player.name] = stats['okCount'] as int;
      nokCounts[player.name] = stats['nokCount'] as int;
    }
    
    if (okCounts.isNotEmpty && nokCounts.isNotEmpty) {
      results['leaderboard'] = {
        'mostOK': okCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
        'mostNOK': nokCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key,
      };
    }
    
    return results;
  }
  
  List<Answer> getCurrentQuestionAnswers() {
    if (_currentSession == null || _currentSession!.currentQuestion == null) {
      return [];
    }
    return _currentSession!.getAnswersForQuestion(
      _currentSession!.currentQuestion!.id,
    );
  }
  
  void endGame() {
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(
        isCompleted: true,
        endTime: DateTime.now(),
      );
      notifyListeners();
    }
  }
  
  void resetGame() {
    _currentSession = null;
    notifyListeners();
  }
  
  void pauseGame() {
    notifyListeners();
  }
  
  void resumeGame() {
    notifyListeners();
  }
}