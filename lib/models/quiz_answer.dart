import 'multiplication_question.dart';

class QuizAnswer {
  final MultiplicationQuestion question;
  final int? userAnswer;

  const QuizAnswer({required this.question, required this.userAnswer});

  bool get isCorrect => userAnswer == question.answer;
}
