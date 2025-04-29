import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final Function(Expense) onSubmit;

  const ExpenseForm({super.key, required this.onSubmit});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory _selectedCategory = ExpenseCategory.food;

  void _submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) return;

    final newExpense = Expense(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: _selectedCategory,
    );

    widget.onSubmit(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: _amountController,
          decoration: const InputDecoration(labelText: 'Amount'),
          keyboardType: TextInputType.number,
        ),
        DropdownButtonFormField<ExpenseCategory>(
          value: _selectedCategory,
          items: ExpenseCategory.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedCategory = value);
          },
          decoration: const InputDecoration(labelText: 'Category'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submitData,
          child: const Text('Add Expense'),
        ),
      ]),
    );
  }
}
