import 'package:flutter/material.dart';

import 'package:expenses_management/ui/expenses_analytics/views/analytics_view.dart';
import 'package:expenses_management/ui/manage_expenses/views/expenses_list_view.dart';

import 'package:expenses_management/routes/route_names.dart';
import 'package:expenses_management/routes/router.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Expenses'),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                appRouter.pushNamed(RouteNames.addExpense);
              },
              elevation: 2.0,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            label: 'Manage Expenses',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'Analytics',
            icon: Icon(Icons.analytics),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          ExpensesListView(),
          AnalyticsView(),
        ],
      ),
    );
  }
}
