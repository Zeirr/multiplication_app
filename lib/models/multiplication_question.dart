class MultiplicationQuestion {
  final int table;
  final int multiplier;

  const MultiplicationQuestion({required this.table, required this.multiplier});

  int get answer => table * multiplier;

  String get label => '$table × $multiplier = ?';
}
