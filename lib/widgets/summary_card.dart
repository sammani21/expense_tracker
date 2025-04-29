import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final double amount;

  const SummaryCard({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text('${amount.toStringAsFixed(2)} LKR',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
