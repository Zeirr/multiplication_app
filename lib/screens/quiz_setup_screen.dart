import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  final List<int> selectedTables = [2];

  void toggleTable(int table) {
    setState(() {
      if (selectedTables.contains(table)) {
        if (selectedTables.length > 1) {
          selectedTables.remove(table);
        }
      } else {
        selectedTables.add(table);
      }
    });
  }

  void startQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            QuizScreen(selectedTables: selectedTables, numberOfQuestions: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedTables.sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Préparer le quiz')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Choisis les tables à réviser',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(10, (index) {
                final table = index + 1;

                return FilterChip(
                  label: Text('Table de $table'),
                  selected: selectedTables.contains(table),
                  onSelected: (_) => toggleTable(table),
                );
              }),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: startQuiz,
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Démarrer le quiz',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
