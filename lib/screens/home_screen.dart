import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_form.dart';
//import '../widgets/expense_list.dart';
import 'dashboard_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  /*void _deleteExpense(String id) {
    setState(() {
      _expenses.removeWhere((exp) => exp.id == id);
    });
  }*/

  void _openAddExpenseDialog() {
    showModalBottomSheet(
      context: context,
      builder: (_) => ExpenseForm(onSubmit: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text("My Expenses"),
  actions: [
    IconButton(
      icon: const Icon(Icons.dashboard),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardScreen(expenses: _expenses),
          ),
        );
      },
    ),
    IconButton(onPressed: _openAddExpenseDialog, icon: const Icon(Icons.add)),
  ],
),

    );
  }
}
