import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/chart/chart_layout.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseDashboard extends StatefulWidget {
  const ExpenseDashboard({super.key});

  @override
  State<ExpenseDashboard> createState() {
    return _ExpenseDashboardState();
  }
}

class _ExpenseDashboardState extends State<ExpenseDashboard> {
  void saveExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void addNewExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) => AddExpense(saveExpense));
  }

  void removeExpense(Expense expense) {
    final expIndex = expenses.indexOf(expense);

    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense Deleted!"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            expenses.insert(expIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainWidget = Expanded(
        child: ExpenseList(
      expenses,
      onDismiss: removeExpense,
    ));

    if (expenses.isEmpty) {
      mainWidget = const Center(
        child: Text("No Expenses to Show!"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ExpTracker"),
        actions: [
          IconButton(
            onPressed: addNewExpense,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            (expenses.isNotEmpty)
                ? ChartLayout(expenses: expenses)
                : const SizedBox(
                    height: 10,
                  ),
            const SizedBox(
              height: 50,
            ),
            mainWidget,
          ],
        ),
      ),
    );
  }
}
