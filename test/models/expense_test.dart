import 'package:flutter_test/flutter_test.dart';
import 'package:spendwise/models/category.dart';
import 'package:spendwise/models/expense.dart';

void main() {
  final e = Expense(id: 'x', title: 'Taxi', amount: 4,
      category: Category.transport, date: DateTime(2026, 10, 1));

  group('Expense', () {
    test('toMap/fromMap round trip keeps all values', () {
      expect(Expense.fromMap(e.toMap()), equals(e));
    });

    test('copyWith changes only the given field', () {
      final c = e.copyWith(amount: 6);
      expect(c.amount, 6);
      expect(c.title, 'Taxi');
      expect(e.amount, 4);
    });

    test('unknown category falls back to other', () {
      final m = e.toMap()..['category'] = 'pets';
      expect(Expense.fromMap(m).category, Category.other);
    });

    test('formattedDate and clearNote work', () {
      final n = Expense(id: 'n', title: 'Gift', amount: 10,
          category: Category.other, date: DateTime(2026, 10, 12),
          note: 'hello');
      expect(n.formattedDate, '12 Oct 2026');
      expect(n.copyWith(clearNote: true).note, isNull);
      expect(n.copyWith(amount: 11).note, 'hello');
    });
  });
}