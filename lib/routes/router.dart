import 'package:go_router/go_router.dart';

import 'package:expenses_management/routes/route_names.dart';

import 'package:expenses_management/ui/manage_expenses/views/expense_form_view.dart';
import 'package:expenses_management/ui/navigation/tabs_screen.dart';

import 'package:expenses_management/data/models/expense.dart';

final appRouter = GoRouter(
  initialLocation: '/', // Set default route
  routes: [
    GoRoute(
      name: RouteNames.home,
      path: '/',
      builder: (context, state) => const TabsScreen(),
    ),
    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, navigationShell) => TabsScreen(
    //     navigationShell: navigationShell,
    //   ),
    //   branches: [
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           name: RouteNames.expenses,
    //           path: '/expenses',
    //           builder: (context, state) => const ExpensesListView(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           name: 'analytics',
    //           path: '/analytics',
    //           builder: (context, state) => const Text('Analysis Page'),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
    GoRoute(
      name: RouteNames.addExpense,
      path: '/add-expense',
      builder: (context, state) => const ExpenseFormView(),
    ),
    GoRoute(
      name: RouteNames.editExpense,
      path: '/edit-expense/:id',
      builder: (context, state) {
        final expense = state.extra as Expense;
        return ExpenseFormView(intialData: expense);
      },
    ),
  ],
);
