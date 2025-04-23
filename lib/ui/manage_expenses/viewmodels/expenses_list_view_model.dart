import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses_management/data/models/expense.dart';
import 'package:expenses_management/data/repositories/expense_repository.dart';

final expensesListViewModelProvider =
    AsyncNotifierProvider<ExpensesListViewModel, List<Expense>>(
  ExpensesListViewModel.new, // Constructor reference
);

class ExpensesListViewModel extends AsyncNotifier<List<Expense>> {
  late final ExpenseRepository _expenseRepository;

  @override
  Future<List<Expense>> build() {
    _expenseRepository = ref.read(expenseRepositoryProvider);
    // await Future.delayed(const Duration(seconds: 3));
    return _expenseRepository.fetchExpenses();
  }

  Future<void> addNewItem(String title, double amount, DateTime dueDate) async {
    state = const AsyncValue.loading();

    final newItem =
        await _expenseRepository.addNewExpense(title, amount, dueDate);

    if (newItem != null) {
      final currentState = state.value ?? [];
      state = AsyncValue.data([...currentState, newItem]);
    } else {
      state = AsyncValue.error(
        'Failed to add new expense: Repository returned null',
        StackTrace.current,
      );
    }
  }

  Future<void> editItem(Expense updatedExpense) async {
    state = const AsyncValue.loading();

    final success = await _expenseRepository.editExpense(updatedExpense);

    if (success) {
      final currentState = state.value ?? [];
      state = AsyncData(currentState.map((element) {
        if (element.id == updatedExpense.id) {
          return updatedExpense;
        }
        return element;
      }).toList());
    } else {
      state = AsyncValue.error(
        'Failed to add new expense: Repository returned null',
        StackTrace.current,
      );
    }
  }

  Future<void> deleteItem(String expenseId) async {
    // state = const AsyncValue.loading();
    final success = await _expenseRepository.deleteExpense(expenseId);

    if (success) {
      final currentState = state.value ?? [];
      state = AsyncData(
        currentState.where((element) => element.id != expenseId).toList(),
      );
    } else {
      state = AsyncValue.error(
        'Failed to add new expense: Repository returned null',
        StackTrace.current,
      );
    }
  }
}
