import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses_management/ui/core/loading_indicator.dart';
import 'package:expenses_management/ui/expenses_analytics/viewmodels/analytics_view_model.dart';
import 'package:expenses_management/ui/expenses_analytics/views/widgets/statistics_table.dart';
import 'package:expenses_management/ui/expenses_analytics/views/widgets/summary_chart.dart';

import 'package:expenses_management/data/models/analytics_summary.dart';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  late final AnalyticsViewModel viewmodel;
  Future<AnalyticsSummary>? _analyticsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to use context.read() here because the widget is in the tree
    viewmodel =
        ProviderScope.containerOf(context).read(analyticsViewModelProvider);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _analyticsFuture = viewmodel.loadSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: _loadData,
        child: FutureBuilder<AnalyticsSummary>(
          future: _analyticsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Failed to load analytics data'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final summaryData = snapshot.data!;

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SummaryChart(summary: summaryData),
                      const SizedBox(height: 16),
                      Text(
                        'Summary Statistics',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      ),
                      StatisticsTable(summaryData: summaryData),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
