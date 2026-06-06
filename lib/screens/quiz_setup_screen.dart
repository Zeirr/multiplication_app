import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  final List<int> selectedTables = [2];
  int numberOfQuestions = 10;

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
        builder: (_) => QuizScreen(
          selectedTables: List.from(selectedTables),
          numberOfQuestions: numberOfQuestions,
        ),
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

            const SizedBox(height: 32),

            const Text(
              'Nombre de questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 5, label: Text('5')),
                ButtonSegment(value: 10, label: Text('10')),
                ButtonSegment(value: 20, label: Text('20')),
              ],
              selected: {numberOfQuestions},
              onSelectionChanged: (values) {
                setState(() {
                  numberOfQuestions = values.first;
                });
              },
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
