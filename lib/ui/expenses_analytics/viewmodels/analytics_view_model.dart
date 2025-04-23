// analytics_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses_management/data/models/analytics_summary.dart';
import 'package:expenses_management/data/repositories/expense_repository.dart';

final analyticsViewModelProvider = Provider<AnalyticsViewModel>((ref) {
  final repo = ref.read(expenseRepositoryProvider);
  return AnalyticsViewModel(expenseRepository: repo);
});

class AnalyticsViewModel {
  final ExpenseRepository _expenseRepository;

  AnalyticsViewModel({required expenseRepository})
      : _expenseRepository = expenseRepository;

  Future<AnalyticsSummary> loadSummary() {
    return _expenseRepository.fetchPastWeekSummary();
  }
}
