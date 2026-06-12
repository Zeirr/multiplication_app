import 'dart:math';
import '../models/multiplication_question.dart';

class QuizService {
  final Random _random = Random();

  List<MultiplicationQuestion> generateUniqueQuestions({
    required List<int> selectedTables,
    required int numberOfQuestions,
  }) {
    final allQuestions = <MultiplicationQuestion>[];

    for (final table in selectedTables) {
      for (int multiplier = 1; multiplier <= 10; multiplier++) {
        allQuestions.add(
          MultiplicationQuestion(table: table, multiplier: multiplier),
        );
      }
    }

    allQuestions.shuffle(_random);

    return allQuestions.take(numberOfQuestions).toList();
  }
}
