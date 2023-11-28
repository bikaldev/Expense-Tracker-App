import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.expenseBucket, required this.total});

  final ExpenseBucket expenseBucket;
  final double total;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: FractionallySizedBox(
          heightFactor: expenseBucket.totalAmount / total,
          widthFactor: 1.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [
                          Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.9),
                          Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.4)
                        ]
                      : [
                          Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.9),
                          Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.4)
                        ],
                ),
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ),
    );
  }
}
