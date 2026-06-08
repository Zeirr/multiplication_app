import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_answer.dart';
import '../models/table_stat.dart';

class ProgressService {
  static const String quizCountKey = 'quiz_count';
  static const String bestScoreKey = 'best_score';
  static const String bestTotalKey = 'best_total';

  Future<void> saveQuizResult(List<QuizAnswer> answers) async {
    final prefs = await SharedPreferences.getInstance();

    final score = answers.where((answer) => answer.isCorrect).length;
    final total = answers.length;

    final quizCount = prefs.getInt(quizCountKey) ?? 0;
    await prefs.setInt(quizCountKey, quizCount + 1);

    final currentBestScore = prefs.getInt(bestScoreKey) ?? 0;
    final currentBestTotal = prefs.getInt(bestTotalKey) ?? 0;

    if (currentBestTotal == 0 || score > currentBestScore) {
      await prefs.setInt(bestScoreKey, score);
      await prefs.setInt(bestTotalKey, total);
    }

    for (final answer in answers) {
      final table = answer.question.table;

      final totalKey = 'table_${table}_total';
      final correctKey = 'table_${table}_correct';

      final oldTotal = prefs.getInt(totalKey) ?? 0;
      final oldCorrect = prefs.getInt(correctKey) ?? 0;

      await prefs.setInt(totalKey, oldTotal + 1);

      if (answer.isCorrect) {
        await prefs.setInt(correctKey, oldCorrect + 1);
      }
    }
  }

  Future<int> getQuizCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(quizCountKey) ?? 0;
  }

  Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(bestScoreKey) ?? 0;
  }

  Future<int> getBestTotal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(bestTotalKey) ?? 0;
  }

  Future<List<TableStat>> getTableStats() async {
    final prefs = await SharedPreferences.getInstance();

    return List.generate(10, (index) {
      final table = index + 1;

      return TableStat(
        table: table,
        correctAnswers: prefs.getInt('table_${table}_correct') ?? 0,
        totalAnswers: prefs.getInt('table_${table}_total') ?? 0,
      );
    });
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
