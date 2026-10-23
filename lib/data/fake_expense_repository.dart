import 'dart:async';
import '../models/expense.dart';
import 'sample_data.dart';

class FakeExpenseRepository {
  final List<Expense> _items = [...sampleExpenses];
  final _controller = StreamController<List<Expense>>.broadcast();

  Future<List<Expense>> loadAll() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.unmodifiable(_items);
  }

  Future<void> add(Expense e) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _items.add(e);
    _controller.add(List.unmodifiable(_items));
  }

  Stream<List<Expense>> watchAll() async* {
    yield List.unmodifiable(_items);
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}