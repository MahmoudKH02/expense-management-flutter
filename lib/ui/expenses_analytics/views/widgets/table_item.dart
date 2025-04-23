import 'package:flutter/material.dart';

class TableItem extends StatelessWidget {
  const TableItem({
    super.key,
    required this.amount,
    required this.displayText,
  });

  final double amount;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount.toStringAsFixed(1),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(displayText),
        ],
      ),
    );
  }
}
