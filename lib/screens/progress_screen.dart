import 'package:flutter/material.dart';
import '../models/table_stat.dart';
import '../services/progress_service.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ProgressService progressService = ProgressService();

  int quizCount = 0;
  int bestScore = 0;
  int bestTotal = 0;
  List<TableStat> tableStats = [];

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final loadedQuizCount = await progressService.getQuizCount();
    final loadedBestScore = await progressService.getBestScore();
    final loadedBestTotal = await progressService.getBestTotal();
    final loadedTableStats = await progressService.getTableStats();

    setState(() {
      quizCount = loadedQuizCount;
      bestScore = loadedBestScore;
      bestTotal = loadedBestTotal;
      tableStats = loadedTableStats;
    });
  }

  Future<void> resetProgress() async {
    await progressService.resetProgress();
    await loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes progrès')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      '🏆 Meilleur score',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      bestTotal == 0
                          ? 'Aucun quiz terminé'
                          : '$bestScore / $bestTotal',
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quiz réalisés : $quizCount',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '📊 Réussite par table',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: tableStats.length,
                itemBuilder: (context, index) {
                  final stat = tableStats[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text('${stat.table}')),
                      title: Text('Table de ${stat.table}'),
                      subtitle: Text(
                        '${stat.correctAnswers} bonnes réponses sur ${stat.totalAnswers}',
                      ),
                      trailing: Text(
                        '${stat.successRate}%',
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
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: resetProgress,
                icon: const Icon(Icons.delete),
                label: const Text('Réinitialiser les progrès'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
