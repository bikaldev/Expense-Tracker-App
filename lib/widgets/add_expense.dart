import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(this.saveExpense, {super.key});

  final void Function(Expense) saveExpense;

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void renderDatePicker() async {
    final DateTime presentDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: presentDate,
        firstDate: DateTime(
          presentDate.year - 1,
          presentDate.month,
          presentDate.day,
        ),
        lastDate: presentDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void onSave() {
    final amount = double.tryParse(_amountController.text);
    final isAmountEmpty = amount == null;

    if (_titleController.text.trim().isNotEmpty &&
        !isAmountEmpty &&
        _selectedDate != null) {
      var newExpense = Expense(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          category: _selectedCategory,
          dateofCreation: DateTime.now());

      widget.saveExpense(newExpense);
      Navigator.pop(context);
    } else {
      // error message;
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text('Please Make Sure There Are No Empty Fields!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(label: Text("Title")),
            maxLength: 50,
            controller: _titleController,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefix: Text("\$"),
                  ),
                  controller: _amountController,
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (_selectedDate == null)
                      ? const Text("No Date Selected")
                      : Text(dateFormatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: renderDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: [
                  ...Category.values.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name.toUpperCase(),
                      ),
                    ),
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: onCancel,
                child: const Text("Cancel"),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: onSave,
                child: const Text("Save Expense"),
              )
            ],
          )
        ],
      ),
    );
  }
}
