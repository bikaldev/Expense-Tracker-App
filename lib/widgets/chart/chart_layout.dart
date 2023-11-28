import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class ChartLayout extends StatelessWidget {
  const ChartLayout({required this.expenses, super.key});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final List<ExpenseBucket> expenseBucketList = [];
    for (var cat in Category.values) {
      expenseBucketList.add(
          ExpenseBucket.filterCategory(category: cat, allExpenses: expenses));
    }
    double maxTotalAmount = 0.0;
    for (var expB in expenseBucketList) {
      if (maxTotalAmount < expB.totalAmount) maxTotalAmount = expB.totalAmount;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? LinearGradient(colors: [
                Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.9),
                Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.2)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : LinearGradient(colors: [
                Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.9),
                Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.2)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: expenseBucketList
                      // .map((e) => Text("HELLO"))
                      .map((e) =>
                          ChartBar(expenseBucket: e, total: maxTotalAmount))
                      .toList()),
            ),
            Row(
              children: expenseBucketList
                  .map(
                    (bucket) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryToIcon[bucket.category],
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
