import 'package:spendwise/data/sample_data.dart';
import 'package:spendwise/utils/expense_x.dart';

void main() {
  final all = sampleExpenses;
  print('All: ${all.length} items, total ${all.total.asMoney}');

  final oct = all.inMonth(2026, 10);
  print('October total: ${oct.total.asMoney}');

  oct.totalsByCategory.forEach((cat, sum) {
    print('${cat.emoji} ${cat.label.padRight(10)} ${sum.asMoney}');
  });

  print('Top category: ${oct.topCategory?.label ?? "none"}');
  print('Newest: ${all.newestFirst.first.title}');
}