import 'package:flutter_test/flutter_test.dart';
import 'package:spendwise/data/sample_data.dart';
import 'package:spendwise/models/category.dart';
import 'package:spendwise/models/expense.dart';
import 'package:spendwise/utils/expense_x.dart';

void main() {
  test('October total is 63.25', () {
    expect(sampleExpenses.inMonth(2026, 10).total, closeTo(63.25, 0.001));
  });

  test('top category of October is bills', () {
    expect(sampleExpenses.inMonth(2026, 10).topCategory, Category.bills);
  });

  test('empty list has no top category and zero total', () {
    expect(<Expense>[].topCategory, isNull);
    expect(<Expense>[].total, 0);
  });

  test('asMoney formats two decimals', () {
    expect(3.0.asMoney, '3.00');
  });

  test('groupByDay groups expenses on two different days', () {
    final list = [
      Expense(id: 'a', title: 'A', amount: 1, category: Category.food,
          date: DateTime(2026, 10, 12, 9)),
      Expense(id: 'b', title: 'B', amount: 2, category: Category.food,
          date: DateTime(2026, 10, 12, 20)),
      Expense(id: 'c', title: 'C', amount: 3, category: Category.food,
          date: DateTime(2026, 10, 13, 8)),
    ];
    final groups = list.groupByDay();
    expect(groups.length, 2);
    expect(groups[DateTime(2026, 10, 12)]!.length, 2);
    expect(groups[DateTime(2026, 10, 13)]!.length, 1);
  });
}