import 'package:flutter/material.dart';
import '../models/multiplication_question.dart';
import '../models/quiz_answer.dart';
import '../services/quiz_service.dart';
import 'result_screen.dart';

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
  final QuizService quizService = QuizService();
  final TextEditingController answerController = TextEditingController();

  late MultiplicationQuestion currentQuestion;

  final List<QuizAnswer> answers = [];

  bool hasAnswered = false;
  String feedback = '';

  int get currentQuestionNumber => answers.length + 1;

  @override
  void initState() {
    super.initState();
    currentQuestion = quizService.generateQuestion(widget.selectedTables);
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void checkAnswer() {
    if (hasAnswered) return;

    final userAnswer = int.tryParse(answerController.text);
    final quizAnswer = QuizAnswer(
      question: currentQuestion,
      userAnswer: userAnswer,
    );

    setState(() {
      answers.add(quizAnswer);
      hasAnswered = true;

      if (quizAnswer.isCorrect) {
        feedback = 'Bonne réponse !';
      } else {
        feedback =
            'Erreur : ${currentQuestion.label} ${currentQuestion.answer}';
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
      answerController.clear();
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
            Text(
              currentQuestion.label,
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: answerController,
              enabled: !hasAnswered,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ta réponse',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: hasAnswered ? null : checkAnswer,
                child: const Text('Valider'),
              ),
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
