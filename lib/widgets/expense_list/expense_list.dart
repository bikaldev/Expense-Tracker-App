import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.expenseList, {super.key, required this.onDismiss});

  final void Function(Expense) onDismiss;

  final List<Expense> expenseList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (BuildContext context, index) => Dismissible(
        key: ValueKey(expenseList[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          margin: Theme.of(context).cardTheme.margin,
        ),
        onDismissed: (direction) {
          onDismiss(expenseList[index]);
        },
        child: ExpenseCard(expenseList[index]),
      ),
    );
  }
}
