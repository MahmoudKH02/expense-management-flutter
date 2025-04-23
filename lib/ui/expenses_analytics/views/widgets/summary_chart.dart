import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:expenses_management/data/models/analytics_summary.dart';

class SummaryChart extends StatelessWidget {
  const SummaryChart({super.key, required this.summary});

  final AnalyticsSummary summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      height: 200,
      width: 350,
      child: BarChart(
        BarChartData(
          maxY: summary.max + 5,
          barGroups: summary.summationPerDay.entries.map((entry) {
            // Use the day of the week as x position (0-6)
            final xPosition = entry.key.weekday - 1; // Monday=0, Sunday=6
            return BarChartGroupData(
              x: xPosition,
              barRods: [BarChartRodData(toY: entry.value)],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      days[value.toInt()],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString());
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
