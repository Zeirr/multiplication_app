import 'package:flutter/material.dart';
import '../models/multiplication_question.dart';
import '../services/quiz_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService quizService = QuizService();
  final TextEditingController answerController = TextEditingController();

  List<int> selectedTables = [2];
  late MultiplicationQuestion currentQuestion;

  int score = 0;
  int totalQuestions = 0;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    currentQuestion = quizService.generateQuestion(selectedTables);
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void toggleTable(int table) {
    setState(() {
      if (selectedTables.contains(table)) {
        if (selectedTables.length > 1) {
          selectedTables.remove(table);
        }
      } else {
        selectedTables.add(table);
      }

      nextQuestion();
    });
  }

  void checkAnswer() {
    final userAnswer = int.tryParse(answerController.text);

    setState(() {
      totalQuestions++;

      if (userAnswer == currentQuestion.answer) {
        score++;
        feedback = 'Bonne réponse !';
      } else {
        feedback = 'Erreur : la bonne réponse était ${currentQuestion.answer}';
      }
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestion = quizService.generateQuestion(selectedTables);
      answerController.clear();
      feedback = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final successRate = totalQuestions == 0
        ? 0
        : ((score / totalQuestions) * 100).round();

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Tables à réviser', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(10, (index) {
                final table = index + 1;

                return FilterChip(
                  label: Text('$table'),
                  selected: selectedTables.contains(table),
                  onSelected: (_) => toggleTable(table),
                );
              }),
            ),
            const SizedBox(height: 32),
            Text(
              currentQuestion.label,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: answerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ta réponse',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: checkAnswer,
              child: const Text('Valider'),
            ),
            TextButton(
              onPressed: nextQuestion,
              child: const Text('Question suivante'),
            ),
            const SizedBox(height: 16),
            Text(feedback, style: const TextStyle(fontSize: 18)),
            const Spacer(),
            Text('Score : $score / $totalQuestions'),
            Text('Réussite : $successRate %'),
          ],
        ),
      ),
    );
  }
}
