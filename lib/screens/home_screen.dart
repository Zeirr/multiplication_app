import 'package:flutter/material.dart';
import '../widgets/app_menu_button.dart';
import 'revision_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToRevision(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RevisionScreen()),
    );
  }

  void _goToQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tables de multiplication')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calculate, size: 96),
            const SizedBox(height: 32),
            AppMenuButton(
              text: 'Réviser les tables',
              icon: Icons.menu_book,
              onPressed: () => _goToRevision(context),
            ),
            const SizedBox(height: 16),
            AppMenuButton(
              text: 'Mode quiz',
              icon: Icons.quiz,
              onPressed: () => _goToQuiz(context),
            ),
          ],
        ),
      ),
    );
  }
}
