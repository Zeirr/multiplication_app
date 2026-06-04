import 'dart:math';
import '../models/multiplication_question.dart';

class QuizService {
  final Random _random = Random();

  MultiplicationQuestion generateQuestion(List<int> selectedTables) {
    final table = selectedTables[_random.nextInt(selectedTables.length)];
    final multiplier = _random.nextInt(10) + 1;

    return MultiplicationQuestion(table: table, multiplier: multiplier);
  }
}
