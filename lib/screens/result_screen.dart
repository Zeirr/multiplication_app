import 'package:flutter/material.dart';
import '../models/quiz_answer.dart';

class ResultScreen extends StatelessWidget {
  final List<QuizAnswer> answers;

  const ResultScreen({super.key, required this.answers});

  int get score => answers.where((answer) => answer.isCorrect).length;

  @override
  Widget build(BuildContext context) {
    final wrongAnswers = answers.where((answer) => !answer.isCorrect).toList();
    final successRate = ((score / answers.length) * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.emoji_events, size: 96),
            const SizedBox(height: 16),
            Text(
              '$score / ${answers.length}',
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            Text(
              'Réussite : $successRate %',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 32),
            if (wrongAnswers.isEmpty)
              const Text(
                'Bravo, aucune erreur !',
                style: TextStyle(fontSize: 20),
              )
            else ...[
              const Text(
                'Erreurs à retravailler',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: wrongAnswers.length,
                  itemBuilder: (context, index) {
                    final answer = wrongAnswers[index];

                    return Card(
                      child: ListTile(
                        title: Text(answer.question.label),
                        subtitle: Text(
                          'Ta réponse : ${answer.userAnswer ?? "vide"}',
                        ),
                        trailing: Text(
                          '${answer.question.answer}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Retour à l’accueil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
