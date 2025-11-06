import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question.dart';

class QuestionService {
  static final QuestionService _instance = QuestionService._internal();
  factory QuestionService() => _instance;
  QuestionService._internal();
  
  List<Question> _allQuestions = [];
  final Map<String, List<Question>> _questionsByCategory = {};
  bool _isInitialized = false;
  
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      final jsonString = await rootBundle.loadString('assets/questions.json');
      final jsonData = jsonDecode(jsonString);
      final questionsList = jsonData['questions'] as List;
      
      _allQuestions = questionsList
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList();
      
      for (var question in _allQuestions) {
        if (!_questionsByCategory.containsKey(question.category)) {
          _questionsByCategory[question.category] = [];
        }
        _questionsByCategory[question.category]!.add(question);
      }
      
      _isInitialized = true;
      print('✅ QuestionService: ${_allQuestions.length} soru yüklendi');
    } catch (e) {
      print('❌ QuestionService hata: $e');
      _isInitialized = false;
    }
  }
  
  Future<List<Question>> getQuestions({
    required String category,
    int count = 10,
    bool premiumOnly = false,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    final categoryQuestions = _questionsByCategory[category] ?? [];
    
    final availableQuestions = premiumOnly
        ? categoryQuestions.where((q) => q.premium).toList()
        : categoryQuestions;
    
    final shuffled = List<Question>.from(availableQuestions)..shuffle();
    return shuffled.take(count).toList();
  }
  
  Future<List<Question>> getMixedQuestions({
    required Map<String, int> categoryCounts,
  }) async {
    final List<Question> mixedQuestions = [];
    
    for (var entry in categoryCounts.entries) {
      final categoryQuestions = await getQuestions(
        category: entry.key,
        count: entry.value,
      );
      mixedQuestions.addAll(categoryQuestions);
    }
    
    mixedQuestions.shuffle();
    return mixedQuestions;
  }
  
  List<String> getAllCategories() {
    return _questionsByCategory.keys.toList();
  }
  
  Map<String, dynamic> getCategoryInfo(String category) {
    final Map<String, dynamic> categories = {
      'ok_not_ok': {
        'name_tr': 'OK mu NOT OK mu?',
        'emoji': '🔥',
        'color': '#FF6B6B',
        'description_tr': 'İlişkide sınırları belirle'
      },
      'kiskanc': {
        'name_tr': 'Ne Kadar Kıskanç?',
        'emoji': '😤',
        'color': '#9B59B6',
        'description_tr': 'Kıskançlık seviyeni test et'
      },
      'aldatma': {
        'name_tr': 'Aldatma mı Değil mi?',
        'emoji': '💔',
        'color': '#E74C3C',
        'description_tr': 'Aldatma sınırlarını çiz'
      },
      'sevgilim_yapabilir': {
        'name_tr': 'Sevgilim Yapabilir mi?',
        'emoji': '❓',
        'color': '#3498DB',
        'description_tr': 'İzin verebileceğin şeyleri keşfet'
      },
      'kac_kizarsin': {
        'name_tr': 'Kaç Kızarsın?',
        'emoji': '😡',
        'color': '#E67E22',
        'description_tr': '1\'den 10\'a öfke seviyeni bul'
      },
    };
    
    return categories[category] ?? {};
  }
  
  int getQuestionCount(String category) {
    return _questionsByCategory[category]?.length ?? 0;
  }
  
  int getTotalQuestionCount() {
    return _allQuestions.length;
  }
  
  int getPremiumQuestionCount(String category) {
    return _questionsByCategory[category]
            ?.where((q) => q.premium)
            .length ??
        0;
  }
}