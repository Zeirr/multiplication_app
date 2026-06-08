import 'package:flutter/material.dart';
import '../models/multiplication_question.dart';
import '../models/quiz_answer.dart';
import '../services/quiz_service.dart';
import 'result_screen.dart';
import '../widgets/numeric_keyboard.dart';

class QuizScreen extends StatefulWidget {
  final List<int> selectedTables;
  final int numberOfQuestions;

  const QuizScreen({
    super.key,
    required this.selectedTables,
    required this.numberOfQuestions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String currentAnswer = '';
  final QuizService quizService = QuizService();

  late MultiplicationQuestion currentQuestion;

  final List<QuizAnswer> answers = [];

  bool hasAnswered = false;
  String feedback = '';

  int get currentQuestionNumber => answers.length + 1;

  void addNumber(String number) {
    if (hasAnswered) return;

    setState(() {
      if (currentAnswer.length < 3) {
        currentAnswer += number;
      }
    });
  }

  void removeLastNumber() {
    if (hasAnswered) return;

    setState(() {
      if (currentAnswer.isNotEmpty) {
        currentAnswer = currentAnswer.substring(0, currentAnswer.length - 1);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    currentQuestion = quizService.generateQuestion(widget.selectedTables);
  }

  void checkAnswer() {
    if (hasAnswered) return;

    final userAnswer = int.tryParse(currentAnswer);
    final quizAnswer = QuizAnswer(
      question: currentQuestion,
      userAnswer: userAnswer,
    );

    setState(() {
      answers.add(quizAnswer);
      hasAnswered = true;

      if (quizAnswer.isCorrect) {
        feedback = '🎉 Bravo, bonne réponse !';

        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            nextQuestion();
          }
        });
      } else {
        feedback =
            '💪 Presque ! La bonne réponse était ${currentQuestion.answer}';
      }
    });
  }

  void nextQuestion() {
    if (!hasAnswered) return;

    if (answers.length >= widget.numberOfQuestions) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(answers: answers)),
      );
      return;
    }

    setState(() {
      currentQuestion = quizService.generateQuestion(widget.selectedTables);
      currentAnswer = '';
      feedback = '';
      hasAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = answers.length / widget.numberOfQuestions;

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 16),
            Text(
              'Question $currentQuestionNumber / ${widget.numberOfQuestions}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.20),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                currentQuestion.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentAnswer.isEmpty ? 'Ta réponse' : currentAnswer,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: currentAnswer.isEmpty ? Colors.grey : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            NumericKeyboard(
              onNumberPressed: addNumber,
              onBackspacePressed: removeLastNumber,
              onValidatePressed: checkAnswer,
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: hasAnswered ? nextQuestion : null,
                child: Text(
                  answers.length >= widget.numberOfQuestions
                      ? 'Voir le résultat'
                      : 'Question suivante',
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              feedback,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
