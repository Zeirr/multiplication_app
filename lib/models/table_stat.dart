class TableStat {
  final int table;
  final int correctAnswers;
  final int totalAnswers;

  const TableStat({
    required this.table,
    required this.correctAnswers,
    required this.totalAnswers,
  });

  int get successRate {
    if (totalAnswers == 0) return 0;
    return ((correctAnswers / totalAnswers) * 100).round();
  }
}
