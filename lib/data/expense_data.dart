import 'package:expense_tracker/models/expense.dart';

List<Expense> expenses = [
  Expense(
      title: "Chess Board",
      amount: 10.0,
      category: Category.leisure,
      dateofCreation: DateTime.now()),
  Expense(
      title: "AWS Course",
      amount: 150.0,
      category: Category.work,
      dateofCreation: DateTime.now()),
  Expense(
      title: "Katti Roll",
      amount: 1.8,
      category: Category.food,
      dateofCreation: DateTime.now())
];
