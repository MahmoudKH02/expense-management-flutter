import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseServiceProvider = Provider((ref) => ExpenseService());

class ExpenseService {
  final _expensesCollection = FirebaseFirestore.instance.collection('expenses');

  Future<QuerySnapshot> getExpenses() async {
    final snapshot = await _expensesCollection.get();
    return snapshot;
  }

  Future<DocumentSnapshot> getExpenseById(String id) async {
    final snapshot = await _expensesCollection.doc(id).get();
    return snapshot;
  }

  Future<DocumentReference?> addExpense(Map<String, dynamic> doc) async {
    try {
      final docRef = await _expensesCollection.add(doc);
      print('Expense added successfully!');
      return docRef;
    } catch (e) {
      print('Failed to add expense: $e');
      return null;
    }
  }

  Future<bool> editExpense(
      String expenseId, Map<String, dynamic> updatedData) async {
    try {
      await _expensesCollection.doc(expenseId).update(updatedData);
      print('Expense updated successfully!');
      return true;
    } catch (e) {
      print('Failed to update expense: $e');
      return false;
    }
  }

  Future<bool> deleteExpense(String expenseId) async {
    try {
      await _expensesCollection.doc(expenseId).delete();
      return true;
    } catch (e) {
      print('Failed to delete expense: $e');
      return false;
    }
  }

  Future<List<DocumentSnapshot>> getPastWeekDueDocuments() async {
    final now = DateTime.now();
    final oneWeekAgo =
        Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 6)));

    final querySnapshot = await _expensesCollection
        .where('dueDate', isGreaterThanOrEqualTo: oneWeekAgo)
        .where('dueDate', isLessThanOrEqualTo: now)
        .orderBy('dueDate')
        .get();

    return querySnapshot.docs;
  }
}
