import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses_management/routes/route_names.dart';
import 'package:expenses_management/routes/router.dart';

import 'package:expenses_management/ui/manage_expenses/views/widgets/delete_background.dart';
import 'package:expenses_management/ui/core/loading_indicator.dart';
import 'package:expenses_management/ui/manage_expenses/viewmodels/expenses_list_view_model.dart';

class ExpensesListView extends ConsumerWidget {
  const ExpensesListView({super.key});

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Item Removed')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesState = ref.watch(expensesListViewModelProvider);
    final expenseListViewModel =
        ref.read(expensesListViewModelProvider.notifier);

    return expensesState.when(
      loading: () => const LoadingIndicator(),
      error: (error, stack) => Text('$error'),

      // actual data if state is ready
      data: (expensesList) => ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expensesList[index].id),
          background: const DeleteBackground(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            expenseListViewModel.deleteItem(expensesList[index].id);
            _showSnackBar(context);
          },
          // list items
          child: ListTile(
            title: Text(expensesList[index].title),
            leading: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: expensesList[index].amountColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            subtitle: Text('\$${expensesList[index].amount.toString()}'),
            trailing: IconButton(
              onPressed: () {
                appRouter.pushNamed(
                  RouteNames.editExpense,
                  pathParameters: {'id': expensesList[index].id},
                  extra: expensesList[index],
                );
              },
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
