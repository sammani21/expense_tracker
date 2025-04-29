import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(String) onDelete;

  const ExpenseList({super.key, required this.expenses, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(child: Text('No expenses yet.'));
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final exp = expenses[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: ListTile(
            title: Text(exp.title),
            subtitle: Text('${exp.amount.toStringAsFixed(2)} LKR • ${exp.category.name.toUpperCase()}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(exp.id),
            ),
          ),
        );
      },
    );
  }
}
