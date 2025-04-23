import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses_management/data/models/analytics_summary.dart';

import 'package:expenses_management/data/models/expense.dart';
import 'package:expenses_management/data/services/expense_service.dart';

final expenseRepositoryProvider = Provider((ref) {
  final service = ref.read(expenseServiceProvider);
  return ExpenseRepository(expenseService: service);
});

class ExpenseRepository {
  final ExpenseService _expenseService;

  ExpenseRepository({required expenseService})
      : _expenseService = expenseService;

  // Retrieve expenses through the service
  Future<List<Expense>> fetchExpenses() async {
    final queryResult = await _expenseService.getExpenses();
    return queryResult.docs.map((doc) => Expense.fromFirestore(doc)).toList();
  }

  Future<Expense> fetchExpenseById(String id) async {
    final queryResult = await _expenseService.getExpenseById(id);
    return Expense.fromFirestore(queryResult);
  }

  Future<Expense?> addNewExpense(
      String title, double amount, DateTime dueDate) async {
    final expenseFields = {
      'title': title,
      'amount': amount,
      'dueDate': dueDate,
    };
    final response = await _expenseService.addExpense(expenseFields);

    if (response != null) {
      // Retrieve the DocumentSnapshot from the DocumentReference
      final snapshot = await response.get();
      return Expense.fromFirestore(snapshot); // Pass the DocumentSnapshot here
    }
    return null;
  }

  Future<bool> editExpense(Expense updatedExpense) {
    final expenseId = updatedExpense.id;
    final updatedData = updatedExpense.toMap();

    updatedData.remove('id');
    return _expenseService.editExpense(expenseId, updatedData);
  }

  Future<bool> deleteExpense(String expenseId) {
    return _expenseService.deleteExpense(expenseId);
  }

  Future<AnalyticsSummary> fetchPastWeekSummary() async {
    var totalAmounts = 0.0;
    var max = 0.0;
    var min = double.maxFinite;

    final Map<DateTime, double> amountsGroup = {};
    final documents = await _expenseService.getPastWeekDueDocuments();

    for (final doc in documents) {
      final expense = Expense.fromFirestore(doc);
      final dayKey = DateTime(
          expense.dueDate.year, expense.dueDate.month, expense.dueDate.day);
      totalAmounts += expense.amount;

      if (expense.amount > max) {
        max = expense.amount;
      }
      if (expense.amount < min) {
        min = expense.amount;
      }

      if (amountsGroup.containsKey(dayKey)) {
        amountsGroup[dayKey] = amountsGroup[dayKey]! + expense.amount;
      } else {
        amountsGroup[dayKey] = expense.amount;
      }
    }

    return AnalyticsSummary(
      amountsGroup,
      totalAmounts,
      totalAmounts / documents.length,
      max,
      min,
    );
  }
}
