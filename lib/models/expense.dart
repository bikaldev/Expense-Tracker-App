import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
var dateFormatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

Map<Category, IconData> categoryToIcon = {
  Category.food: Icons.restaurant,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight,
  Category.work: Icons.work
};

class Expense {
  final String title;
  final double amount;
  final Category category;
  final DateTime dateofCreation;
  final String id;

  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      required this.dateofCreation})
      : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(dateofCreation);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.filterCategory(
      {required this.category, required List<Expense> allExpenses})
      : expenses =
            allExpenses.where((item) => item.category == category).toList();

  double get totalAmount {
    double sum = 0.0;
    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
