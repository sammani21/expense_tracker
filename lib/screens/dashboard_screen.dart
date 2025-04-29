import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';
import '../widgets/summary_card.dart';

class DashboardScreen extends StatelessWidget {
  final List<Expense> expenses;

  const DashboardScreen({super.key, required this.expenses});

  double get totalToday {
    final today = DateTime.now();
    return expenses
        .where((e) =>
            e.date.day == today.day &&
            e.date.month == today.month &&
            e.date.year == today.year)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  double get totalThisMonth {
    final now = DateTime.now();
    return expenses
        .where((e) => e.date.month == now.month && e.date.year == now.year)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  Map<ExpenseCategory, double> get categoryTotals {
    final Map<ExpenseCategory, double> data = {};
    for (var e in expenses) {
      data[e.category] = (data[e.category] ?? 0) + e.amount;
    }
    return data;
  }

  List<PieChartSectionData> get pieChartSections {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.brown,
    ];
    final total = categoryTotals.values.fold(0.0, (a, b) => a + b);
    final entries = categoryTotals.entries.toList();

    return List.generate(entries.length, (i) {
      final percent = (entries[i].value / total) * 100;
      return PieChartSectionData(
        color: colors[i % colors.length],
        value: entries[i].value,
        title: '${percent.toStringAsFixed(1)}%',
        titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SummaryCard(title: 'Today\'s Total', amount: totalToday),
            const SizedBox(height: 8),
            SummaryCard(title: 'Monthly Total', amount: totalThisMonth),
            const SizedBox(height: 24),
            const Text('Category Breakdown', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.3,
              child: PieChart(
                PieChartData(
                  sections: pieChartSections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
