import 'package:flutter/material.dart';

import 'models/category.dart';
import 'models/expense.dart';
import 'utils/expense_x.dart';

void main() {
  runApp(const SpendWiseApp());
}

class SpendWiseApp extends StatelessWidget {
  const SpendWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpendWise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF760A3A), // TIU maroon
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<Expense> _expenses = [];

  void _add(String title, double amount, Category category) {
    setState(() {
      _expenses.add(Expense(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        amount: amount,
        category: category,
        date: DateTime.now(),
      ));
    });
  }

  void _addSampleExpense() => _add('Coffee', 2.5, Category.food);

  void _addTaxi() => _add('Taxi', 4, Category.transport);

  void _reset() => setState(_expenses.clear);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendWise'),
        actions: [
          IconButton(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Center(
        child: _buildSummary(scheme, text),
      ),
      floatingActionButton: _buildButtons(),
    );
  }

  Widget _buildSummary(ColorScheme scheme, TextTheme text) {
    final top = _expenses.topCategory;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_balance_wallet,
            size: 96, color: scheme.primary),
        const SizedBox(height: 16),
        Text('Welcome to SpendWise', style: text.headlineSmall),
        const SizedBox(height: 8),
        Text('${_expenses.length} expenses · '
            '${_expenses.total.asMoney} USD'),
        if (top != null) ...[
          const SizedBox(height: 8),
          Text('Top: ${top.emoji} ${top.label}'),
        ],
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: _addTaxi,
          icon: const Icon(Icons.local_taxi),
          label: const Text('Add taxi'),
        ),
        const SizedBox(height: 12),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: _addSampleExpense,
          icon: const Icon(Icons.add),
          label: const Text('Add coffee'),
        ),
      ],
    );
  }
}