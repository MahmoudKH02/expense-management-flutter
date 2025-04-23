import 'package:expenses_management/data/models/analytics_summary.dart';
import 'package:flutter/material.dart';

import 'package:expenses_management/ui/expenses_analytics/views/widgets/table_item.dart';

class StatisticsTable extends StatelessWidget {
  const StatisticsTable({super.key, required this.summaryData});

  final AnalyticsSummary summaryData;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            TableItem(amount: summaryData.total, displayText: 'Total'),
            TableItem(amount: summaryData.max, displayText: 'Max Amount'),
          ],
        ),
        TableRow(
          children: [
            TableItem(amount: summaryData.average, displayText: 'Average'),
            TableItem(amount: summaryData.min, displayText: 'Min Amount'),
          ],
        ),
      ],
    );
  }
}
