import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime dueDate;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
  });

  factory Expense.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Expense(
      id: doc.id,
      title: data['title'],
      amount: data['amount'],
      dueDate: (data['dueDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'dueDate': dueDate,
    };
  }

  Expense copyWith({String? title, double? amount, DateTime? dueDate}) {
    return Expense(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Color get amountColor {
    if (amount < 15) {
      return Colors.lightGreen;
    } else if (amount < 30) {
      return Colors.orangeAccent;
    } else {
      return Colors.redAccent;
    }
  }
}
